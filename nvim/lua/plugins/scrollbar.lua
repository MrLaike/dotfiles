return {
    'petertriho/nvim-scrollbar',
    config = function ()
        require("scrollbar").setup({
            folds = 10,
            handle = {
                text = " ",
                color = "#222222",
                color_nr = nil,
                blend = 30,
            },
            marks = {
                Search = { color = "#e3ffee" },
                Error = { color = "#ff3432" },
                Warn = { color = "#efae6f" },
                Info = { color = "#efafee" },
                Hint = { color = "#1f2e6f" },
                Misc = { color = "#1f2e3f" },
            }
        })
    end
}
