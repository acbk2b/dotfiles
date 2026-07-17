return {
    {
        "dlyongemallo/diffview.nvim",
        version = "*",
        cmd = {
            "DiffviewOpen",
            "DiffviewToggle",
            "DiffviewFileHistory",
            "DiffviewDiffFiles",
            "DiffviewLog",
        },
    },
    {
        "neovim/nvim-lspconfig",
        config = function()
            local lsp_attach_group = vim.api.nvim_create_augroup("UserLspAttach", { clear = true })

            local function setup_servers()
                local lombok_path = os.getenv("HOME") .. "/.local/share/java/lombok.jar"
                local project_root = vim.fn.getcwd()
                local project_name = vim.fn.fnamemodify(project_root, ":t")
                local project_hash = vim.fn.sha256(project_root):sub(1, 12)
                local workspace_dir = vim.fn.stdpath("data") ..
                    "/jdtls-workspace/" .. project_name .. "-" .. project_hash
                local lsps = {
                    { "gopls" },
                    {
                        "jdtls",
                        {
                            cmd = {
                                vim.fn.exepath("jdtls"),
                                "--jvm-arg=-javaagent:" .. lombok_path,
                                "-data",
                                workspace_dir,
                            },
                        },
                    },
                    { "lua_ls" },
                    { "pyright" },
                    { "rust_analyzer" },
                    { "terraformls" },
                }

                for _, lsp in ipairs(lsps) do
                    local name, server_config = lsp[1], lsp[2]
                    if server_config then
                        vim.lsp.config(name, server_config)
                    end
                    vim.lsp.enable(name)
                end
            end

            local function set_completion_keymaps()
                local map = vim.keymap.set
                map('i', '<Tab>', function()
                    return vim.fn.pumvisible() == 1 and '<C-n>' or '<Tab>'
                end, { expr = true, silent = true })
                map('i', '<S-Tab>', function()
                    return vim.fn.pumvisible() == 1 and '<C-p>' or '<S-Tab>'
                end, { expr = true, silent = true })
                map('i', '<CR>', function()
                    return vim.fn.pumvisible() == 1 and '<C-y>' or '<CR>'
                end, { expr = true, silent = true })
            end

            local function set_lsp_keymaps(bufnr, client)
                local map = vim.keymap.set
                local function jump_diagnostic(count)
                    vim.diagnostic.jump({
                        count = count,
                        on_jump = function(diagnostic, diagnostic_bufnr)
                            if not diagnostic then
                                return
                            end

                            vim.diagnostic.open_float(diagnostic_bufnr, {
                                scope = "line",
                                focus = false,
                            })
                        end,
                    })
                end

                map("n", "<leader>dj", function()
                    jump_diagnostic(1)
                end, { buffer = bufnr })
                map("n", "<leader>dk", function()
                    jump_diagnostic(-1)
                end, { buffer = bufnr })
                map("n", "<leader>r", vim.lsp.buf.rename, { buffer = bufnr })
                map("n", "<leader>c", vim.lsp.buf.code_action, { buffer = bufnr })
                map("n", "<leader>e", vim.diagnostic.open_float, { buffer = bufnr, desc = "Show lsp errors/warnings" })

                if client and client.name == "jdtls" then
                    map("n", "<leader>oi", function()
                        vim.lsp.buf.code_action({
                            context = { only = { "source.organizeImports" } },
                            apply = true,
                        })
                    end, { buffer = bufnr, desc = "Organize imports" })
                end
            end

            local function on_lsp_attach(args)
                local client = vim.lsp.get_client_by_id(args.data.client_id)

                if client and client:supports_method("textDocument/completion") then
                    vim.lsp.completion.enable(true, args.data.client_id, args.buf, {
                        autotrigger = true,
                    })
                end

                -- Disable built-in autocomplete in Java buffers -> _extremely_ slow
                if client and client.name == "jdtls" then
                    vim.api.nvim_set_option_value("autocomplete", false, { scope = "local", buf = args.buf })
                end

                set_lsp_keymaps(args.buf, client)
            end

            setup_servers()
            set_completion_keymaps()
            vim.api.nvim_create_autocmd("LspAttach", {
                group = lsp_attach_group,
                callback = on_lsp_attach,
            })
        end,
    },
}
