{
  pkgs,
  inputs,
  ...
}: {
  imports = [inputs.nixvim.homeModules.nixvim];

  programs.nixvim = {
    enable = true;
    defaultEditor = true;

    globals = {
      mapleader = " ";
      maplocalleader = ",";
    };

    opts = {
      expandtab = true;
      tabstop = 2;
      shiftwidth = 2;
      softtabstop = 2;

      ignorecase = true;
      smartcase = true;
      incsearch = true;
      hlsearch = true;

      number = true;
      relativenumber = false;
      cursorline = true;
      termguicolors = true;
      background = "dark";
      mouse = "a";
      clipboard = "unnamedplus";

      updatetime = 200;
      timeoutlen = 400;

      swapfile = false;
      backup = false;
      writebackup = false;

      linebreak = true;
      breakindent = true;
      wrap = false;

      signcolumn = "yes";
      splitbelow = true;
      splitright = true;
      scrolloff = 8;
      sidescrolloff = 8;

      completeopt = ["menu" "menuone" "noselect"];
      pumheight = 12;
      conceallevel = 2;
      concealcursor = "nc";
    };

    colorschemes.gruvbox = {
      enable = true;
      settings = {
        contrast = "hard";
        italic = {
          strings = true;
          comments = true;
          operators = false;
        };
        transparent_background = false;
      };
    };

    keymaps = [
      {
        mode = "n";
        key = "<leader>w";
        action = ":w<CR>";
        options.desc = "save";
      }
      {
        mode = "n";
        key = "<leader>q";
        action = ":q<CR>";
        options.desc = "quit";
      }
      {
        mode = "n";
        key = "<leader>x";
        action = ":wq<CR>";
        options.desc = "save and quit";
      }

      {
        mode = "n";
        key = "<leader>e";
        action = "<cmd>NvimTreeToggle<CR>";
        options.desc = "file explorer";
      }

      {
        mode = "n";
        key = "<leader>h";
        action = ":bprevious<CR>";
        options.desc = "prev buffer";
      }
      {
        mode = "n";
        key = "<leader>l";
        action = ":bnext<CR>";
        options.desc = "next buffer";
      }
      {
        mode = "n";
        key = "<leader>b";
        action = ":buffers<CR>";
        options.desc = "list buffers";
      }

      {
        mode = "n";
        key = "<C-h>";
        action = "<C-w>h";
        options.desc = "window left";
      }
      {
        mode = "n";
        key = "<C-j>";
        action = "<C-w>j";
        options.desc = "window down";
      }
      {
        mode = "n";
        key = "<C-k>";
        action = "<C-w>k";
        options.desc = "window up";
      }
      {
        mode = "n";
        key = "<C-l>";
        action = "<C-w>l";
        options.desc = "window right";
      }

      {
        mode = "n";
        key = "<leader>ff";
        action = "<cmd>Telescope find_files<CR>";
        options.desc = "find files";
      }
      {
        mode = "n";
        key = "<leader>fg";
        action = "<cmd>Telescope live_grep<CR>";
        options.desc = "live grep";
      }
      {
        mode = "n";
        key = "<leader>fb";
        action = "<cmd>Telescope buffers<CR>";
        options.desc = "find buffers";
      }
      {
        mode = "n";
        key = "<leader>fh";
        action = "<cmd>Telescope help_tags<CR>";
        options.desc = "help tags";
      }
      {
        mode = "n";
        key = "<leader>fr";
        action = "<cmd>Telescope oldfiles<CR>";
        options.desc = "recent files";
      }
      {
        mode = "n";
        key = "<leader>fu";
        action = "<cmd>Telescope undo<CR>";
        options.desc = "undo tree";
      }
      {
        mode = "n";
        key = "<leader>f/";
        action = "<cmd>Telescope current_buffer_fuzzy_find<CR>";
        options.desc = "search in buffer";
      }

      {
        mode = "n";
        key = "gd";
        action = "<cmd>lua vim.lsp.buf.definition()<CR>";
        options.desc = "go to definition";
      }
      {
        mode = "n";
        key = "gr";
        action = "<cmd>lua vim.lsp.buf.references()<CR>";
        options.desc = "references";
      }
      {
        mode = "n";
        key = "gi";
        action = "<cmd>lua vim.lsp.buf.implementation()<CR>";
        options.desc = "implementation";
      }
      {
        mode = "n";
        key = "K";
        action = "<cmd>lua vim.lsp.buf.hover()<CR>";
        options.desc = "hover docs";
      }
      {
        mode = "n";
        key = "<leader>ca";
        action = "<cmd>lua vim.lsp.buf.code_action()<CR>";
        options.desc = "code action";
      }
      {
        mode = "n";
        key = "<leader>rn";
        action = "<cmd>lua vim.lsp.buf.rename()<CR>";
        options.desc = "rename symbol";
      }
      {
        mode = "n";
        key = "<leader>d";
        action = "<cmd>lua vim.diagnostic.open_float()<CR>";
        options.desc = "line diagnostics";
      }
      {
        mode = "n";
        key = "[d";
        action = "<cmd>lua vim.diagnostic.goto_prev()<CR>";
        options.desc = "prev diagnostic";
      }
      {
        mode = "n";
        key = "]d";
        action = "<cmd>lua vim.diagnostic.goto_next()<CR>";
        options.desc = "next diagnostic";
      }
      {
        mode = "n";
        key = "<leader>qf";
        action = "<cmd>Trouble diagnostics toggle<CR>";
        options.desc = "diagnostics panel";
      }

      {
        mode = "n";
        key = "gcc";
        action = "<Plug>(comment_toggle_linewise_current)";
        options.desc = "comment line";
      }
      {
        mode = "x";
        key = "gc";
        action = "<Plug>(comment_toggle_linewise_visual)";
        options.desc = "comment selection";
      }
    ];

    plugins = {
      lualine.enable = true;
      web-devicons.enable = true;
      bufferline.enable = true;
      nvim-tree.enable = true;
      which-key.enable = true;
      todo-comments.enable = true;
      indent-blankline.enable = true;
      gitsigns.enable = true;
      comment.enable = true;
      nvim-autopairs.enable = true;
      trouble.enable = true;

      telescope = {
        enable = true;
        extensions = {
          undo.enable = true;
          fzf-native.enable = true;
        };
      };

      treesitter = {
        enable = true;
        grammarPackages = with pkgs.vimPlugins.nvim-treesitter.builtGrammars; [
          nix
          lua
          python
          javascript
          typescript
          c
          cpp
          bash
          markdown
          json
          yaml
          toml
          gitignore
          cmake
          make
          query
          regex
        ];
      };

      lsp = {
        enable = true;

        servers = {
          nixd.enable = true;
          lua_ls.enable = true;
          pyright.enable = true;
          bashls.enable = true;
          jsonls.enable = true;
          yamlls.enable = true;
          marksman.enable = true;
          clangd.enable = true;
        };

        inlayHints = true;
      };

      cmp = {
        enable = true;
        autoEnableSources = true;
        settings = {
          snippet.expand = "function(args) require('luasnip').lsp_expand(args.body) end";
          mapping = {
            "<C-b>" = "cmp.mapping.scroll_docs(-4)";
            "<C-f>" = "cmp.mapping.scroll_docs(4)";
            "<C-Space>" = "cmp.mapping.complete()";
            "<C-e>" = "cmp.mapping.abort()";
            "<CR>" = "cmp.mapping.confirm({ select = true })";
          };
          sources = [
            {name = "nvim_lsp";}
            {name = "luasnip";}
            {name = "buffer";}
            {name = "path";}
          ];
          formatting = {
            fields = ["abbr" "kind" "menu"];
          };
          window = {
            completion = {
              border = "rounded";
            };
            documentation = {
              border = "rounded";
            };
          };
        };
      };

      luasnip.enable = true;
      friendly-snippets.enable = true;

      conform-nvim = {
        enable = true;
        settings = {
          formattersByFt = {
            nix = ["nixfmt"];
            lua = ["stylua"];
            python = ["black"];
            javascript = ["prettierd"];
            typescript = ["prettierd"];
            json = ["prettierd"];
            yaml = ["prettierd"];
            markdown = ["prettierd"];
            sh = ["shfmt"];
            c = ["clang-format"];
            cpp = ["clang-format"];
            cmake = ["cmake-format"];
          };
        };
      };
    };

    extraConfigLua = ''
      vim.diagnostic.config({
        virtual_text = true,
        signs = true,
        underline = true,
        update_in_insert = false,
        severity_sort = true,
        float = {
          border = "rounded",
          source = "if_many",
        },
      })

      vim.api.nvim_create_autocmd("LspAttach", {
        callback = function(event)
          local keymap = vim.keymap.set

          keymap("n", "gd", vim.lsp.buf.definition, { buffer = event.buf, silent = true })
          keymap("n", "gr", vim.lsp.buf.references, { buffer = event.buf, silent = true })
          keymap("n", "gi", vim.lsp.buf.implementation, { buffer = event.buf, silent = true })
          keymap("n", "K", vim.lsp.buf.hover, { buffer = event.buf, silent = true })
          keymap("n", "<leader>rn", vim.lsp.buf.rename, { buffer = event.buf, silent = true })
          keymap("n", "<leader>ca", vim.lsp.buf.code_action, { buffer = event.buf, silent = true })
          keymap("n", "<leader>d", vim.diagnostic.open_float, { buffer = event.buf, silent = true })
        end,
      })
    '';

    extraPackages = with pkgs; [
      nixd
      lua-language-server
      pyright
      bash-language-server
      vscode-langservers-extracted
      clang-tools
      cmake-language-server

      stylua
      black
      prettierd
      shfmt
      clang-tools
      cmake-format

      ripgrep
      fd
      git
    ];
  };
}
