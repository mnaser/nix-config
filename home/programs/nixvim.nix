{ pkgs }:

{
  enable = true;
  defaultEditor = true;
  viAlias = true;
  vimAlias = true;

  options = {
    relativenumber = true;
    signcolumn = "yes";
  };

  globals = {
    better_whitespace_guicolor = "#f38ba8";
  };

  keymaps = [
    {
      key = "<leader><Bslash>";
      action = "<Cmd>Neotree position=left toggle<CR>";
      options = {
        desc = "Toggle Neotree";
        silent = true;
      };
    }
    {
      mode = "n";
      key = "<leader>f";
      action = "<Cmd>lua vim.lsp.buf.format()<CR>";
      options = {
        desc = "Format";
        silent = true;
      };
    }
  ];

  extraPackages = with pkgs; [
    ansible
    ansible-lint
  ];

  extraPlugins = with pkgs.vimPlugins; [
    ansible-vim
    vim-better-whitespace
    vim-helm
    vim-sort-motion
    #vim-go
  ];

  colorschemes.catppuccin = {
    enable = true;
  };

  plugins.nix = {
    enable = true;
  };

  plugins.none-ls = {
    enable = true;
    debug = true;

    sources = {
      diagnostics = { };
    };
  };

  plugins.lsp = {
    enable = true;

    servers = {
      ansiblels.enable = true;
      gopls.enable = true;
      pyright.enable = true;
      nixd.enable = true;

      pylsp.enable = true;
      pylsp.settings = {
        plugins.black.enabled = true;
        plugins.isort.enabled = true;
      };
    };
  };

  plugins.telescope = {
    enable = true;

    keymaps = {
      "<C-p>" = {
        desc = "Find Files";
        action = "find_files";
      };
      "<leader>fg" = {
        desc = "Live Grep";
        action = "live_grep";
      };
      "<leader>fb" = {
        desc = "Find Buffers";
        action = "buffers";
      };
      "<leader>fh" = {
        desc = "Find Help";
        action = "help_tags";
      };
    };

    extensions.fzf-native = {
      enable = true;
    };
  };

  plugins.treesitter = {
    enable = true;
  };

  plugins.copilot-lua = {
    enable = true;

    panel.enabled = false;
    suggestion.enabled = false;

    filetypes = {
      "*" = true;
    };
  };

  plugins.copilot-cmp = {
    enable = true;
  };

  plugins.nvim-cmp = {
    enable = true;

    mappingPresets = [ "insert" "cmdline" ];
    mapping = {
      "<C-Space>" = "cmp.mapping.complete()";
      "<CR>" = "cmp.mapping.confirm({ select = false })";
    };

    sources = [
      { name = "copilot"; }
      { name = "nvim_lsp"; }
    ];
  };

  plugins.commentary = {
    enable = true;
  };

  plugins.lastplace = {
    enable = true;
  };

  plugins.lualine = {
    enable = true;
  };

  plugins.neo-tree = {
    enable = true;

    window.position = "current";
  };

  plugins.cursorline = {
    enable = true;

    cursorline = {
      timeout = 0;
    };
  };

  plugins.which-key = {
    enable = true;
  };

  # plugins.tmux-navigator = {
  #   enable = true;
  # };

  # plugins.gitgutter = {
  #   enable = true;
  # };

  # plugins.project-nvim = {
  #   enable = true;
  # };
}
