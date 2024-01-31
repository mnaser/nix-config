{ config, pkgs, ... }:

{
  programs.vscode = import ./programs/vscode.nix { inherit pkgs; };
}
