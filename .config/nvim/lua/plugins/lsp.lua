return {
    {
        "neovim/nvim-lspconfig",
        event = { "BufReadPre", "BufNewFile" },
        cmd = { "LspInfo", "LspLog", "LspStart", "LspRestart", "LspStop" },
        dependencies = { "saghen/blink.cmp" },
        config = function()
            local lsp_attach_group = vim.api.nvim_create_augroup("UserLspAttach", { clear = true })

            local function setup_diagnostics()
                local sev = vim.diagnostic.severity
                vim.diagnostic.config({
                    severity_sort = true,
                    underline = true,
                    update_in_insert = false,
                    float = { source = "if_many" },
                    virtual_text = { spacing = 2, prefix = "●", source = "if_many" },
                    signs = {
                        text = {
                            [sev.ERROR] = " ",
                            [sev.WARN] = " ",
                            [sev.INFO] = " ",
                            [sev.HINT] = "󰌵 ",
                        },
                    },
                })
            end

            local function setup_servers()
                -- Advertise blink.cmp completion capabilities (snippets, etc.) to every server
                vim.lsp.config("*", {
                    capabilities = require("blink.cmp").get_lsp_capabilities(),
                })

                local lombok_path = os.getenv("HOME") .. "/.local/share/java/lombok.jar"
                local project_root = vim.fn.getcwd()
                local project_name = vim.fn.fnamemodify(project_root, ":t")
                local project_hash = vim.fn.sha256(project_root):sub(1, 12)
                local workspace_dir = vim.fn.stdpath("data") ..
                    "/jdtls-workspace/" .. project_name .. "-" .. project_hash
                vim.lsp.config("jdtls", {
                    cmd = {
                        vim.fn.exepath("jdtls"),
                        "--jvm-arg=-javaagent:" .. lombok_path,
                        "-data",
                        workspace_dir,
                    },
                })

                vim.lsp.enable({
                    "gopls",
                    "jdtls",
                    "lua_ls",
                    "pyright",
                    "rust_analyzer",
                    "terraformls",
                    "ts_ls",
                })
            end

            -- Global toggles (not buffer-local -> work before/without attach)
            local function set_global_keymaps()
                local map = vim.keymap.set
                map("n", "<leader>uh", function()
                    vim.lsp.inlay_hint.enable(not vim.lsp.inlay_hint.is_enabled({ bufnr = 0 }), { bufnr = 0 })
                end, { desc = "Toggle inlay hints" })
                map("n", "<leader>ud", function()
                    vim.diagnostic.enable(not vim.diagnostic.is_enabled())
                end, { desc = "Toggle diagnostics" })
                map("n", "<leader>cd", vim.diagnostic.open_float, { desc = "Line diagnostics" })
            end

            -- Built-in defaults already cover: K, grn, gra, grr, gri, grt, grx, gO, <C-s>, ]d/[d
            local function set_buffer_keymaps(buf)
                local function map(lhs, rhs, desc)
                    vim.keymap.set("n", lhs, rhs, { buffer = buf, desc = desc })
                end
                map("gd", vim.lsp.buf.definition, "Goto definition")
                map("gD", vim.lsp.buf.declaration, "Goto declaration")
                map("<leader>cf", function() vim.lsp.buf.format({ async = true }) end, "Format buffer")
            end

            -- Highlight other references to the symbol under the cursor
            local function enable_document_highlight(buf)
                local group = vim.api.nvim_create_augroup("UserLspHighlight" .. buf, { clear = true })
                vim.api.nvim_create_autocmd({ "CursorHold", "CursorHoldI" }, {
                    group = group,
                    buffer = buf,
                    callback = vim.lsp.buf.document_highlight,
                })
                vim.api.nvim_create_autocmd({ "CursorMoved", "CursorMovedI" }, {
                    group = group,
                    buffer = buf,
                    callback = vim.lsp.buf.clear_references,
                })
                vim.api.nvim_create_autocmd("LspDetach", {
                    group = group,
                    buffer = buf,
                    callback = function()
                        vim.lsp.buf.clear_references()
                        vim.api.nvim_del_augroup_by_id(group)
                    end,
                })
            end

            local function on_lsp_attach(args)
                local buf = args.buf
                local client = vim.lsp.get_client_by_id(args.data.client_id)
                if not client then return end

                set_buffer_keymaps(buf)

                if client:supports_method("textDocument/inlayHint") then
                    vim.lsp.inlay_hint.enable(true, { bufnr = buf })
                end

                if client:supports_method("textDocument/codeLens") then
                    vim.lsp.codelens.enable(true, { bufnr = buf })
                end

                if client:supports_method("textDocument/documentHighlight") then
                    enable_document_highlight(buf)
                end

                -- Enable LSP folding
                if client:supports_method("textDocument/foldingRange") then
                    local win = vim.api.nvim_get_current_win()
                    if vim.api.nvim_win_get_buf(win) == buf then
                        vim.wo[win][0].foldmethod = "expr"
                        vim.wo[win][0].foldexpr = "v:lua.vim.lsp.foldexpr()"
                        -- Keep top-level declarations open while folding nested regions.
                        vim.wo[win][0].foldlevel = 1
                    end
                end
            end

            setup_diagnostics()
            setup_servers()
            set_global_keymaps()
            vim.api.nvim_create_autocmd("LspAttach", {
                group = lsp_attach_group,
                callback = on_lsp_attach,
            })
        end,
    },
}
