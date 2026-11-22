{
  users.khanhbui.home.base = hmArgs: {
    programs.ssh = {
      enable = true;
      enableDefaultConfig = false;
      includes = [
        # old config files
        "~/.ssh/private_config"
        # might be a better pattern
        "${hmArgs.config.home.homeDirectory}/.ssh/hosts/*"
      ];
      settings = {
        "github.com" = {
          ControlMaster = "auto";
          ControlPath = "~/.ssh/ctl-%r@%h:%p";
          ControlPersist = "10m";
        };
        "Host *" = {
          IdentityFile = "${hmArgs.config.home.homeDirectory}/.ssh/id_ed25519";
          AddKeysToAgent = "5m";
        };
      };
    };

    # This is needed for AddKeysToAgent to work
    # TODO: Might want to setup ssh forwarding
    services.ssh-agent.enable = true;
  };

  nixos.modules.base = {
    users.users.khanhbui.openssh.authorizedKeys.keys = [
      "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIIn5PdMtXzuX2ULHS2rjxK6CpV58CQSF+YEofmazs6o+ khanhbui@kb-meshy"
      "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIAnRVsEqCtimaMAatcbJqNsQiJB78VeQgoCr3pNF2AVB khanhbui@kb-fw13p"
    ];
  };

}
