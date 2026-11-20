{
  users.khanhbui.home.gui =
    hmArgs@{ pkgs, ... }:
    {
      services.gpg-agent = {
        enable = true;
        # TODO: gpg forwarding to avoid needing pinentry-curses on the host machine
        pinentry.package = hmArgs.pkgs.pinentry-curses;
      };
      programs.gpg = {
        enable = true;
      };
    };
}
