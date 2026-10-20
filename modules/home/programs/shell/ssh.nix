{ ... }:

{
  programs.ssh = {
    enableDefaultConfig = false;
    includes = [
      "~/.ssh/private_config"
    ];
    settings = {
      "github.com" = {
        IdentityFile = "~/.ssh/id_ed25519";
        ControlMaster = "auto";
        ControlPath = "~/.ssh/ctl-%r@%h:%p";
        ControlPersist = "10m";
      };
      "*" = {
        AddKeysToAgent = "5m";
      };
    };
  };
}
