return {
    'petertriho/nvim-scrollbar',
    config = function () 
        require("scrollbar").setup({
            folds = 1000,
            handle = {
                text = " ",
                color = "#333333",
                color_nr = nil,
                blend = 30,
            },
            marks = {
                Search = { color = "#e3ffee" },
                Error = { color = "#ff3432" },
                Warn = { color = "#3273ff" },
                Info = { color = "#7dff32" },
                Hint = { color = "#7dff32" },
                Misc = { color = "#7dff32" },
            }
        })
    end
}
