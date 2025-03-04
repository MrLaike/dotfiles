return {
    "ravibrock/spellwarn.nvim",
    event = "VeryLazy",
    config = function ()
        require('spellwarn').setup({
            event = {
                "CursorHold",
                "InsertLeave",
                "TextChanged",
                "TextChangedI",
                "TextChangedP",
            },
            enable = true,
            ft_config = {
                alpha   = false,
                help    = false,
                lazy    = false,
                lspinfo = false,
                mason   = false,
            },
            ft_default = true,
            max_file_size = nil,
            severity = {
                spellbad   = "WARN",
                spellcap   = "HINT",
                spelllocal = "HINT",
                spellrare  = "INFO",
            },
            prefix = "possible misspelling(s): ",
            diagnostic_opts = { severity_sort = true },
        })
    end,
}
