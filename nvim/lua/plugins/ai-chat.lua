return {
    "olimorris/codecompanion.nvim",
    dependencies = {
        "nvim-lua/plenary.nvim",
        "nvim-treesitter/nvim-treesitter",
    },
    config = function()
        require("codecompanion").setup({
            strategies = {
                chat = {
                    adapter = "ollama",
                    keymaps = {
                        close = {
                            modes = {
                                n = "q",
                                i = "C-[[",
                            },
                            index = 4,
                            callback = "keymaps.close",
                            description = "Close Chat",
                        },
                    }
                },
                inline = {
                    adapter = "ollama",
                },
            },
            opts = {
                -- Set debug logging
                log_level = "DEBUG",
            },
            adapters = {
                ollama = function()
                    return require("codecompanion.adapters").extend("openai_compatible", {
                        env = {
                            url = "http://localhost:11434",
                            chat_url = "/v1/chat/completions",
                        },
                        scheme = {
                            model = {
                                default = "qwen2.5-coder"
                            }
                        }

                    })
                end,
            },
            
        })
    end,
}
