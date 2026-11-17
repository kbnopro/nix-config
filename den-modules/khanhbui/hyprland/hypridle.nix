{
  users.khanhbui = {
    home.gui = {
      services.hypridle = {
        enable = true;
        settings = {
          listener = [
            {
              timeout = 5 * 60; # 5 minutes
              on-timeout = ''hyprctl eval 'hl.dispatch(hl.dsp.dpms({ action = "disable" }))' '';
              on-resume = ''hyprctl eval 'hl.dispatch(hl.dsp.dpms({ action = "enable" }))' '';
            }
          ];
        };
      };
    };
  };
}
