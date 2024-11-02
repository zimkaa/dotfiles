{
  config,
  pkgs,
  ...
}: {
  programs.git.enable = true;
  # programs.git.lfs.enable = true;
  programs.git.userName = "Anton Zimin";
  programs.git.userEmail = "56966172+zimkaa@users.noreply.github.com";
  # programs.git.signing.key = null;
  # programs.git.signing.signByDefault = true;

  programs.git.extraConfig = {
    pull = {
      rebase = true;
    };
    init = {
      defaultBranch = "main";
    };
  };
}
