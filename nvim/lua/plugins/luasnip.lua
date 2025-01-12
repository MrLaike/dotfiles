return {
    "L3MON4D3/LuaSnip",
    dependencies = { "rafamadriz/friendly-snippets" },
    build = "make install_jsregexp",
    opts = {
        use_show_condition = false,
        show_autosnippets = true,
        history = true,
    },
}

