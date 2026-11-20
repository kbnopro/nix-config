{
  users.khanhbui.home.base = {
    programs.direnv = {
      enable = true;
      nix-direnv.enable = true;
    };
    programs.git = {
      ignores = [
        ".envrc"
        ".direnv"
      ];
    };
  };
}
