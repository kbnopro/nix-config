{ ... }:
{
  system.defaults = {
    dock.autohide = true;
    NSGlobalDomain.KeyRepeat = 2;
    screencapture.target = "clipboard";
  };

  security.pam.services.sudo_local.touchIdAuth = true;
}
