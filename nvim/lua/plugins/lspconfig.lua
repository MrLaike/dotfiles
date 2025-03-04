return {
    "neovim/nvim-lspconfig",
    lazy = false,
    dependencies = {
        {
            "williamboman/mason.nvim",
            lazy = false,
        },
        {
            "williamboman/mason-lspconfig.nvim",
            cmd = { "LspInstall", "LspUninstall" },
        },
    },
    init = function()
        require('mason').setup()

        local lspconfig = require('lspconfig');
        local capabilities = require('cmp_nvim_lsp').default_capabilities()
        capabilities.textDocument.foldingRange = {
            dynamicRegistration = false,
            lineFoldingOnly = true
        }

        lspconfig.qmlls.setup{}

        local project_phpactor_config = function ()
            local root_dir = vim.loop.cwd()
            local config_path = root_dir .. "/.phpactor.json"

            -- Read and parse the .phpactor.json file if it exists
            local f = io.open(config_path, "r")
            if not f then
                return {}
            end
            local content = f:read("*a")
            f:close()

            local success, json = pcall(vim.fn.json_decode, content)
            if success and json then
                return vim.tbl_deep_extend("force", {}, json)
            end
            return {}
        end
        local servers = require('mason-lspconfig').get_installed_servers()
        local config = {
            ["phpactor"] = {
                filetypes = { "php", "hphp" },
                root_dir = lspconfig.util.root_pattern(
                    '.phpactor.json',
                    '.git',
                    'composer.json'
                ),
                init_options = project_phpactor_config()
            },
            ["html"] = {
                filetypes = { "html", "jsx", "php", "hphp" },
                root_dir = function()
                    return vim.loop.cwd()
                end,
                init_options = {
                    configurationSection = { "html", "css", "javascript" },
                    embeddedLanguages = {
                        css = true,
                        javascript = true
                    },
                    provideFormatter = true

                }
            },
            ["clangd"] = {
                cmd = {'clangd', '--background-index', '--clang-tidy', '--log=verbose'},
                filetypes = { "c", "cpp", "objc", "objcpp", "cuda", "proto" },
                root_dir = lspconfig.util.root_pattern(
                    '.clangd',
                    '.clang-tidy',
                    '.clang-format',
                    'compile_commands.json',
                    'compile_flags.txt',
                    'configure.ac',
                    '.git'
                ),
                init_options = {
                },
            },
            ["lua_ls"] = {
                settings = {
                    Lua = {
                        runtime = { version = "LuaJIT" },
                        workspace = {
                            checkThirdParty = false,
                            library = {
                                "${3rd}/luv/library",
                                unpack(vim.api.nvim_get_runtime_file("", true))
                            }
                        },
                        completion = {
                            callSnippet = "Replace"
                        }
                    }
                },
            },
            ["ruff"] = {
                init_options = {
                    settings = {
                        args = {"--ignore", "E501"},
                    },
                }
            },
            ["pylsp"] = {
                settings = {
                    pylsp = {
                        plugins = {
                            black = { enabled = true },
                            autopep8 = { enabled = false },
                            yapf = { enabled = false },

                            pylint = { enabled = true, executable = "pylint", args = {"--disable=C0114,C0115,C0116,C0301,R0903"}},
                            pyflakes = { enabled = false },
                            pycodestyle = { enabled = false },
                            pydocstyle = { enabled = false },

                            pylsp_mypy = { enabled = true },
                            jedi_completion = { enabled = true, fuzzy = true, include_params = true },
                            pyls_isort = { enabled = true },

                        }
                    }
                }
            }
        }
        for _, lsp in ipairs(servers) do
            local default_config = {
                capabilities = capabilities,
            }
            for k,v in pairs(config[lsp] or {}) do default_config[k] = v end
            lspconfig[lsp].setup(default_config)

        end
    end

}
