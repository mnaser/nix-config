{ pkgs }:

{
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
}
