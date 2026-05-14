{
  pkgs,
  nixvim,
  ...
}: {
  imports = [nixvim.homeModules.nixvim];

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
      relativenumber = true;
      cursorline = true;
      termguicolors = true;
      background = "dark";
      mouse = "a";
      clipboard = "unnamedplus";

      updatetime = 300;
      swapfile = false;
      backup = false;
      writebackup = false;

      linebreak = true;
      breakindent = true;
      wrap = false;
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
        options.desc = "Save";
      }
      {
        mode = "n";
        key = "<leader>q";
        action = ":q<CR>";
        options.desc = "Quit";
      }
      {
        mode = "n";
        key = "<leader>x";
        action = ":wq<CR>";
        options.desc = "Save & Quit";
      }

      {
        mode = "n";
        key = "<leader>h";
        action = ":bprevious<CR>";
        options.desc = "Prev buffer";
      }
      {
        mode = "n";
        key = "<leader>l";
        action = ":bnext<CR>";
        options.desc = "Next buffer";
      }
      {
        mode = "n";
        key = "<leader>b";
        action = ":buffers<CR>";
        options.desc = "List buffers";
      }

      {
        mode = "n";
        key = "<C-h>";
        action = "<C-w>h";
        options.desc = "Window left";
      }
      {
        mode = "n";
        key = "<C-j>";
        action = "<C-w>j";
        options.desc = "Window down";
      }
      {
        mode = "n";
        key = "<C-k>";
        action = "<C-w>k";
        options.desc = "Window up";
      }
      {
        mode = "n";
        key = "<C-l>";
        action = "<C-w>l";
        options.desc = "Window right";
      }

      {
        mode = "n";
        key = "<leader>ff";
        action = "<cmd>Telescope find_files<CR>";
        options.desc = "Find files";
      }
      {
        mode = "n";
        key = "<leader>fg";
        action = "<cmd>Telescope live_grep<CR>";
        options.desc = "Live grep";
      }
      {
        mode = "n";
        key = "<leader>fb";
        action = "<cmd>Telescope buffers<CR>";
        options.desc = "Find buffers";
      }
      {
        mode = "n";
        key = "<leader>fh";
        action = "<cmd>Telescope help_tags<CR>";
        options.desc = "Find help";
      }

      {
        mode = "n";
        key = "gd";
        action = "<cmd>lua vim.lsp.buf.definition()<CR>";
        options.desc = "Go to definition";
      }
      {
        mode = "n";
        key = "gr";
        action = "<cmd>lua vim.lsp.buf.references()<CR>";
        options.desc = "References";
      }
      {
        mode = "n";
        key = "K";
        action = "<cmd>lua vim.lsp.buf.hover()<CR>";
        options.desc = "Hover docs";
      }
      {
        mode = "n";
        key = "<leader>ca";
        action = "<cmd>lua vim.lsp.buf.code_action()<CR>";
        options.desc = "Code action";
      }

      {
        mode = "n";
        key = "gcc";
        action = "<Plug>(comment_toggle_linewise_current)";
        options.desc = "Comment line";
      }
      {
        mode = "x";
        key = "gc";
        action = "<Plug>(comment_toggle_linewise_visual)";
        options.desc = "Comment selection";
      }
    ];

    plugins = {
      lualine.enable = true;
      web-devicons.enable = true;

      telescope = {
        enable = true;
        extensions = {
          undo.enable = true;
        };
      };

      treesitter = {
        enable = true;
        grammarPackages = with pkgs.vimPlugins.nvim-treesitter.builtGrammars; [
          nix
          lua
          python
          javascript
          bash
          markdown
          json
          yaml
          toml
          gitignore
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
        };
        keymaps = {
          silent = true;
          diagnostic = {
            "<leader>e" = "vim.diagnostic.open_float";
            "[d" = "vim.diagnostic.goto_prev";
            "]d" = "vim.diagnostic.goto_next";
          };
        };
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
        };
      };

      luasnip.enable = true;

      comment.enable = true;
      gitsigns.enable = true;
      which-key.enable = true;
      todo-comments.enable = true;
      friendly-snippets.enable = true;

      indent-blankline.enable = true;
    };

    extraPackages = with pkgs; [
      nixd
      lua-language-server
      pyright
      bash-language-server
      vscode-langservers-extracted

      nixfmt-rfc-style
      stylua
      black
      prettierd

      ripgrep
      fd

      git
    ];
  };
}
