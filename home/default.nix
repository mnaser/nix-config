{ config, pkgs, ... }:

{
  home.stateVersion = "23.05";

  programs.home-manager.enable = true;
  programs.git = import ./programs/git.nix;
  programs.starship = import ./programs/starship.nix;
  programs.zsh = import ./programs/zsh.nix;
  programs.eza = import ./programs/eza.nix;
  programs.bat = import ./programs/bat.nix;
  programs.tmux = import ./programs/tmux.nix { inherit pkgs; };
  programs.nixvim = import ./programs/nixvim.nix { inherit pkgs; };
  programs.fzf = import ./programs/fzf.nix;
  programs.zoxide = import ./programs/zoxide.nix;
  programs.direnv = import ./programs/direnv.nix;
  programs.gh = import ./programs/gh.nix;
  programs.ripgrep = import ./programs/ripgrep.nix;

  # home.packages = with pkgs; [
  #   coreutils
  #   dive
  #   fd
  #   git-review
  #   go
  #   jq
  #   krew
  #   kubectl
  #   kubernetes-helm
  #   mysql.client
  #   # openstackclient
  #   patchutils
  #   poetry
  #   procps
  #   pwgen
  #   python311
  #   python311Packages.tox
  #   ripgrep
  #   earthly
  #   sops
  #   vault
  # ];
}
