return {
    {
        "stevearc/conform.nvim",
        event = "BufWritePre",
        cmd = "ConformInfo",
        opts = {
            formatters_by_ft = {
                java = { "google-java-format" },
                json = { "jq" },
                markdown = { "prettier" },
                python = { "black" },
                rego = { "opa_fmt" },
                swift = { "swiftformat" },
                terraform = { "terraform_fmt" },
                tf = { "terraform_fmt" },
                yaml = { "prettier" },
            },
            format_on_save = { timeout_ms = 2000, lsp_format = "fallback" },
        },
    },
}
