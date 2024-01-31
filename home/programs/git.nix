{
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
}
