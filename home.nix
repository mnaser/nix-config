{ config, pkgs, ... }:

{
  # Home Manager needs a bit of information about you and the
  # paths it should manage.
  home.username = "mnaser";
  home.homeDirectory = "/Users/mnaser";

  # This value determines the Home Manager release that your
  # configuration is compatible with. This helps avoid breakage
  # when a new Home Manager release introduces backwards
  # incompatible changes.
  #
  # You can update Home Manager without changing this value. See
  # the Home Manager release notes for a list of state version
  # changes in each release.
  home.stateVersion = "23.05";

  # Let Home Manager install and manage itself.
  programs.home-manager.enable = true;

  xdg.configFile = {
    "alacritty/catppuccin" = {
      source = builtins.fetchGit {
        url = "https://github.com/catppuccin/alacritty.git";
        rev = "3c808cbb4f9c87be43ba5241bc57373c793d2f17";
      };
    };
  };

  programs.git = {
    enable = true;

    userName = "Mohammed Naser";
    userEmail = "mnaser@vexxhost.com";

    extraConfig = {
      init = {
        defaultBranch = "main";
      };

      pull = {
        rebase = true;
      };

      push = {
        autoSetupRemote = true;
      };
    };
  };

  programs.zsh = {
    enable = true;
    enableAutosuggestions = true;

    oh-my-zsh = {
      enable = true;
      plugins = [
        "fzf"
        "git"
        "kubectl"
        "starship"
      ];
    };
  };

  programs.eza = {
    enable = true;
    enableAliases = true;
  };

  programs.bat = {
    enable = true;
  };

  programs.tmux = {
    enable = true;
    terminal = "xterm-256color";
    baseIndex = 1;
    keyMode = "vi";
    mouse = true;

    plugins = with pkgs.tmuxPlugins; [
      vim-tmux-navigator

      {
      	plugin = catppuccin;
	extraConfig = ''
	  set -g @catppuccin_window_default_text "#W"
          set -g @catppuccin_window_current_text "#W"
	'';
      }
    ];

    extraConfig = ''
      set -ga terminal-overrides ",xterm-256color:Tc"
    '';
  };

  programs.nixvim = {
    enable = true;
    defaultEditor = true;
    viAlias = true;
    vimAlias = true;

    options = {
      number = true;
    };

    colorschemes.catppuccin = {
      enable = true;
    };

    plugins.lastplace = {
      enable = true;
    };

    plugins.tmux-navigator = {
      enable = true;
    };

    plugins.gitgutter = {
      enable = true;
    };

    plugins.cursorline = {
      enable = true;
    };

    plugins.treesitter = {
      enable = true;
    };

    plugins.project-nvim = {
      enable = true;
    };

    plugins.telescope = {
      enable = true;

      extensions.fzf-native = {
	enable = true;
      };

      keymaps = {
      	"<C-p>" = "find_files";
      };
    };

    plugins.lsp = {
      enable = true;

      servers = {
	gopls.enable = true;
	pyright.enable = true;
        nixd.enable = true;
      };
    };

    plugins.copilot-lua = {
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

    plugins.copilot-cmp = {
      enable = true;
    };

    globals = {
      better_whitespace_guicolor = "#f38ba8";
      go_fmt_command = "goimports";
    };

    extraPlugins = with pkgs.vimPlugins; [
      vim-better-whitespace
      vim-go
    ];
  };

  programs.fzf = {
    enable = true;
    tmux = {
      enableShellIntegration = true;
    };
  };

  programs.zoxide = {
    enable = true;
    enableZshIntegration = true;
  };

  programs.direnv = {
    enable = true;
    nix-direnv.enable = true;
  };

  programs.gh = {
    enable = true;
  };

  programs.alacritty = {
    enable = true;

    settings = {
      import = [
        "~/.config/alacritty/catppuccin/catppuccin-mocha.yml"
      ];

      font.normal.family = "CaskaydiaCove Nerd Font";
      font.size = 14;
    };
  };

  home.packages = with pkgs; [
    alacritty
    coreutils
    fd
    git-review
    jq
    krew
    kubectl
    kubernetes-helm
    nixpkgs-fmt
    openstackclient
    patchutils
    poetry
    procps
    pwgen
    python311Packages.tox
    ripgrep
    sops
    starship
    youtube-dl
  ];
}
