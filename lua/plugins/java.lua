return {
    {
        "mfussenegger/nvim-jdtls",
        opts = function()
            local cmd = { vim.fn.exepath("jdtls") }
            local bundles = {
                vim.fn.glob(
                    "/home/z191954/.local/share/nvim/mason/packages/java-debug-adapter/extension/server/com.microsoft.java.debug.plugin-*.jar",
                    1
                ),
            }
            -- This is the new part
            local java_test_bundles = vim.split(vim.fn.glob("/home/z191954/server/*.jar", 1), "\n")
            local excluded = {
                "com.microsoft.java.test.runner-jar-with-dependencies.jar",
                "jacocoagent.jar",
            }
            for _, java_test_jar in ipairs(java_test_bundles) do
                local fname = vim.fn.fnamemodify(java_test_jar, ":t")
                if not vim.tbl_contains(excluded, fname) then
                    table.insert(bundles, java_test_jar)
                end
            end
            if LazyVim.has("mason.nvim") then
                local lombok_jar = vim.fn.expand("$MASON/share/lombok-nightly/lombok.jar")
                table.insert(cmd, string.format("--jvm-arg=-javaagent:%s", lombok_jar))
                table.insert(cmd, "--jvm-arg=-Xmx16G")
            end
            return {
                root_dir = function(path)
                    return vim.fs.root(path, vim.lsp.config.jdtls.root_markers)
                end,

                -- How to find the project name for a given root dir.
                project_name = function(root_dir)
                    return root_dir and vim.fs.basename(root_dir)
                end,

                -- Where are the config and workspace dirs for a project?
                jdtls_config_dir = function(project_name)
                    return vim.fn.stdpath("cache") .. "/jdtls/" .. project_name .. "/config"
                end,
                jdtls_workspace_dir = function(project_name)
                    return vim.fn.stdpath("cache") .. "/jdtls/" .. project_name .. "/workspace"
                end,

                -- How to run jdtls. This can be overridden to a full java command-line
                -- if the Python wrapper script doesn't suffice.
                cmd = cmd,
                full_cmd = function(opts)
                    local fname = vim.api.nvim_buf_get_name(0)
                    local root_dir = opts.root_dir(fname)
                    local project_name = opts.project_name(root_dir)
                    local cmd = vim.deepcopy(opts.cmd)
                    if project_name then
                        vim.list_extend(cmd, {
                            "-configuration",
                            opts.jdtls_config_dir(project_name),
                            "-data",
                            opts.jdtls_workspace_dir(project_name),
                        })
                    end
                    return cmd
                end,
                -- These depend on nvim-dap, but can additionally be disabled by setting false here.
                dap = { hotcodereplace = "auto", config_overrides = {} },
                -- Can set this to false to disable main class scan, which is a performance killer for large project
                dap_main = {},
                test = true,
                settings = {
                    java = {
                        inlayHints = {
                            parameterNames = {
                                enabled = "all",
                            },
                        },
                        completion = {
                            maxResults = 50,
                        },
                    },
                    format = {
                        enabled = true,
                        settings = {
                            url = "vim.fn.expand('~/codestyle/opst-commons/ts-opst-commons-formatter.xml')",
                            profile = "ts-opst-commons",
                        },
                    },
                },
                init_options = {
                    documentSymbol = {
                        --dynamicRegistration = false,
                        hierarchicalDocumentSymbolSupport = true,
                        labelSupport = true,
                    },
                    bundles = bundles,
                },
            }
        end,
    },
}
