{ config, lib, ... }:
let
  cfg = config.services.openssh;
in
{
  config = lib.mkIf cfg.enable {
    users.users.khanhbui.openssh.authorizedKeys.keys = [
      "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIJy4fvbn0Jf75XNl//nx7jvQqJ2+0DvhgpD2e5i++J98 khanhbui@kb-xps15"
      "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIIn5PdMtXzuX2ULHS2rjxK6CpV58CQSF+YEofmazs6o+ khanhbui@kb-meshy"
    ];
  };
}
