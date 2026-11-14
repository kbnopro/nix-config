{
  lib,
  ...
}:
{
  services.logind.settings = {
    Login = {
      HandleLidSwitch = lib.mkDefault "suspend-then-hibernate";
    };
  };
  systemd.sleep.settings.Sleep.HibernateDelaySec = "2h";
}
