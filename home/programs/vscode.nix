{ pkgs }:

{
  enable = true;

  enableUpdateCheck = false;
  enableExtensionUpdateCheck = false;

  mutableExtensionsDir = true;

  extensions = with pkgs.vscode-extensions; [
    bradlc.vscode-tailwindcss
    esbenp.prettier-vscode
    github.copilot
    github.copilot-chat
    github.github-vscode-theme
    github.vscode-github-actions
    github.vscode-pull-request-github
    golang.go
    jnoortheen.nix-ide
    mkhl.direnv
    ms-azuretools.vscode-docker
    ms-python.black-formatter
    ms-python.isort
    ms-python.python
    ms-vscode-remote.remote-ssh
    redhat.vscode-xml
    redhat.vscode-yaml
  ] ++ pkgs.vscode-utils.extensionsFromVscodeMarketplace [
    {
      name = "earthfile-syntax-highlighting";
      publisher = "earthly";
      version = "0.0.16";
      sha256 = "sha256-xU1v1NL1A6EDG+kv8Ri16xuZeQdRFzTnMOCLGpCmlg8=";
    }
    {
      name = "flake8";
      publisher = "ms-python";
      version = "2023.11.13551006";
      sha256 = "sha256-AfH5F+Rub4ZQIBo/QtEZ68OV+7+mYD523uF760tWDJE=";
    }
    {
      name = "mypy-type-checker";
      publisher = "ms-python";
      version = "2023.9.10221010";
      sha256 = "sha256-wkk/yW7GzfHkpiFkyxPDwMPpu7ujBT0sBCTW0uS/4E4=";
    }
    {
      name = "pylint";
      publisher = "ms-python";
      version = "2023.11.13481007";
      sha256 = "sha256-rn+6vT1ZNpjzHwIy6ACkWVvQVCEUWG2abCoirkkpJts=";
    }
    {
      name = "remote-explorer";
      publisher = "ms-vscode";
      version = "0.5.2024011009";
      sha256 = "sha256-oo6lcsB0HmE3XiWVmf4gXz+Xctlj/VFgV31DttwD3Rg=";
    }
    {
      name = "ansible";
      publisher = "redhat";
      version = "2.10.130";
      sha256 = "sha256-Ddjc70ZgJs+qKb6qwVrde4VJJ15/mwHu+9TTCJ4E+bY=";
    }
  ];

  userSettings = {
    "editor.cursorBlinking" = "smooth";
    "editor.fontFamily" = "Fira Code";
    "editor.fontLigatures" = true;
    "editor.fontSize" = 14;
    "editor.fontWeight" = "450";
    "editor.minimap.enabled" = false;
    "editor.stickyScroll.enabled" = true;
    "files.insertFinalNewline" = true;
    "files.trimFinalNewlines" = true;
    "terminal.integrated.fontSize" = 14;
    "workbench.colorTheme" = "GitHub Dark Default";
    "workbench.tree.enableStickyScroll" = true;
  };
}
