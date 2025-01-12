return {
    'nmac427/guess-indent.nvim',
    as = "guess-indent",
    config = function()
        require('guess-indent').setup {
            -- autoformate command :GuessIndent
            auto_cmd = true,
            override_editorconfig = false,
            filetype_exclude = {
              "tutor",
            },
            buftype_exclude = {
              "help",
              "nofile",
              "terminal",
              "prompt",
            },
            on_tab_options = {
              ["expandtab"] = false,
            },
            on_space_options = {
              ["expandtab"] = true,
              ["tabstop"] = "detected",
              ["softtabstop"] = "detected",
              ["shiftwidth"] = "detected",
            },
        }
    end
}
