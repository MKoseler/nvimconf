return {
  {
    "nvim-java/nvim-java",
    config = function()
      require("neoconf").setup({})
      require("java").setup({
        jdk = {
          auto_install = false,
        },
        jdtls = {
          enable = true,
          version = "1.52.0",
        },
        java_test = {
          enable = true,
          version = "0.43.2",
        },
      })
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
      require("lspconfig").jdtls.setup({
        -- Your custom jdtls settings goes here
        init_options = {
          documentSymbol = {
            --dynamicRegistration = false,
            hierarchicalDocumentSymbolSupport = true,
            labelSupport = true,
          },
          bundles = bundles,
        },
        --cmd_env = {
        --JAVA_HOME = "/usr/lib/jvm/java-21-openjdk-amd64",
        --PATH = "/usr/lib/jvm/java-21-openjdk-amd64/bin",
        --},
        settings = {
          format = {
            enabled = true,
            settings = {
              url = "vim.fn.expand('~/codestyle/opst-commons/ts-opst-commons-formatter.xml')",
              profile = "ts-opst-commons",
            },
          },
          java = {
            inlayHints = {
              parameterNames = {
                enabled = "all",
              },
            },
          },
        },
      })
    end,
  },
  {
    "neovim/nvim-lspconfig",
    dependencies = {
      "nvim-java/nvim-java",
    },
  },
  {
    "rcasia/neotest-java",
    enabled = false,
  },
}
