{
  enable = true;
  enableAutosuggestions = true;

  envExtra = ''
    export TELEPORT_LOGIN=mnaser
  '';

  oh-my-zsh = {
    enable = true;
    plugins = [
      "fzf"
      "git"
      "kubectl"
      "starship"
    ];
  };
}
