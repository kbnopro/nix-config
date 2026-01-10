{
  pkgs,
  ...
}:
let
  wasm = pkgs.stdenv.mkDerivation rec {
    pname = "vim-zellij-navigator-wasm";
    version = "0.3.0";

    src = pkgs.fetchurl {
      url = "https://github.com/hiasr/vim-zellij-navigator/releases/download/${version}/vim-zellij-navigator.wasm";
      hash = "sha256-wpIxPkmVpoAgOsdQKYuipSlDAbsD3/n6tTuOEriJHn0";
    };

    dontUnpack = true;

    installPhase = ''
      cp -v "$src" "$out"
    '';
  };

  paneBinds = [
    {
      bind = {
        _args = [ "c" ];
        _children = [
          { SwitchToMode._args = [ "renamepane" ]; }
          { PaneNameInput._args = [ 0 ]; }
        ];
      };
    }
    {
      bind = {
        _args = [ "d" ];
        _children = [
          { NewPane._args = [ "down" ]; }
          { SwitchToMode._args = [ "locked" ]; }
        ];
      };
    }
    {
      bind = {
        _args = [ "e" ];
        _children = [
          { TogglePaneEmbedOrFloating = { }; }
          { SwitchToMode._args = [ "locked" ]; }
        ];
      };
    }
    {
      bind = {
        _args = [ "f" ];
        _children = [
          { ToggleFocusFullscreen = { }; }
          { SwitchToMode._args = [ "locked" ]; }
        ];
      };
    }
    {
      bind = {
        _args = [ "h" ];
        _children = [
          { MoveFocus._args = [ "left" ]; }
        ];
      };
    }
    {
      bind = {
        _args = [ "i" ];
        _children = [
          { TogglePanePinned = { }; }
          { SwitchToMode._args = [ "locked" ]; }
        ];
      };
    }
    {
      bind = {
        _args = [ "j" ];
        _children = [
          { MoveFocus._args = [ "down" ]; }
        ];
      };
    }
    {
      bind = {
        _args = [ "k" ];
        _children = [
          { MoveFocus._args = [ "up" ]; }
        ];
      };
    }
    {
      bind = {
        _args = [ "l" ];
        _children = [
          { MoveFocus._args = [ "right" ]; }
        ];
      };
    }
    {
      bind = {
        _args = [ "n" ];
        _children = [
          { NewPane = { }; }
          { SwitchToMode._args = [ "locked" ]; }
        ];
      };
    }
    {
      bind = {
        _args = [ "p" ];
        _children = [
          { SwitchToMode._args = [ "normal" ]; }
        ];
      };
    }
    {
      bind = {
        _args = [ "r" ];
        _children = [
          { NewPane._args = [ "right" ]; }
          { SwitchToMode._args = [ "locked" ]; }
        ];
      };
    }
    {
      bind = {
        _args = [ "s" ];
        _children = [
          { NewPane._args = [ "stacked" ]; }
          { SwitchToMode._args = [ "locked" ]; }
        ];
      };
    }
    {
      bind = {
        _args = [ "w" ];
        _children = [
          { ToggleFloatingPanes = { }; }
          { SwitchToMode._args = [ "locked" ]; }
        ];
      };
    }
    {
      bind = {
        _args = [ "x" ];
        _children = [
          { CloseFocus = { }; }
          { SwitchToMode._args = [ "locked" ]; }
        ];
      };
    }
    {
      bind = {
        _args = [ "z" ];
        _children = [
          { TogglePaneFrames = { }; }
          { SwitchToMode._args = [ "locked" ]; }
        ];
      };
    }
    {
      bind = {
        _args = [ "tab" ];
        _children = [
          { SwitchFocus = { }; }
        ];
      };
    }
    {
      bind = {
        _args = [ "left" ];
        _children = [
          { MoveFocus._args = [ "left" ]; }
        ];
      };
    }
    {
      bind = {
        _args = [ "down" ];
        _children = [
          { MoveFocus._args = [ "down" ]; }
        ];
      };
    }
    {
      bind = {
        _args = [ "up" ];
        _children = [
          { MoveFocus._args = [ "up" ]; }
        ];
      };
    }
    {
      bind = {
        _args = [ "right" ];
        _children = [
          { MoveFocus._args = [ "right" ]; }
        ];
      };
    }
  ];

  sharedBinds = [
    {
      shared_among = {
        _args = [
          "normal"
          "locked"
        ];
        _children = [
          {
            bind = {
              _args = [ "Ctrl h" ];
              _children = [
                {
                  MessagePlugin = {
                    _args = [
                      "file:${wasm}"
                    ];
                    _children = [
                      {
                        name = [ "move_focus" ];
                        payload = [ "left" ];
                      }
                    ];
                  };
                }
              ];
            };
          }
          {
            bind = {
              _args = [ "Ctrl j" ];
              _children = [
                {
                  MessagePlugin = {
                    _args = [
                      "file:${wasm}"
                    ];
                    _children = [
                      {
                        name = [ "move_focus" ];
                        payload = [ "down" ];
                      }
                    ];
                  };
                }
              ];
            };
          }
          {
            bind = {
              _args = [ "Ctrl k" ];
              _children = [
                {
                  MessagePlugin = {
                    _args = [
                      "file:${wasm}"
                    ];
                    _children = [
                      {
                        name = [ "move_focus" ];
                        payload = [ "up" ];
                      }
                    ];
                  };
                }
              ];
            };
          }
          {
            bind = {
              _args = [ "Ctrl l" ];
              _children = [
                {
                  MessagePlugin = {
                    _args = [
                      "file:${wasm}"
                    ];
                    _children = [
                      {
                        name = [ "move_focus" ];
                        payload = [ "right" ];
                      }
                    ];
                  };
                }
              ];
            };
          }
          {
            bind = {
              _args = [ "Alt f" ];
              _children = [
                { ToggleFloatingPanes = { }; }
              ];
            };
          }
          {
            bind = {
              _args = [ "Alt n" ];
              _children = [
                { NewPane = { }; }
              ];
            };
          }
          {
            bind = {
              _args = [ "Alt p" ];
              _children = [
                { TogglePaneInGroup = { }; }
              ];
            };
          }
          {
            bind = {
              _args = [ "Alt Shift p" ];
              _children = [
                { ToggleGroupMarking = { }; }
              ];
            };
          }
          {
            bind = {
              _args = [ "Alt [" ];
              _children = [
                { PreviousSwapLayout = { }; }
              ];
            };
          }
          {
            bind = {
              _args = [ "Alt ]" ];
              _children = [
                { NextSwapLayout = { }; }
              ];
            };
          }
        ];
      };
    }
    {
      shared_except = {
        _args = [
          "locked"
          "renametab"
          "renamepane"
        ];
        _children = [
          {
            bind = {
              _args = [ "Ctrl g" ];
              _children = [
                { SwitchToMode._args = [ "locked" ]; }
              ];
            };
          }
          {
            bind = {
              _args = [ "Ctrl q" ];
              _children = [
                { Quit = { }; }
              ];
            };
          }
        ];

      };
    }
    {
      shared_except = {
        _args = [
          "locked"
          "entersearch"
        ];
        _children = [
          {
            bind = {
              _args = [ "enter" ];
              _children = [
                { SwitchToMode._args = [ "locked" ]; }
              ];
            };
          }
        ];
      };
    }
    {
      shared_except = {
        _args = [
          "locked"
          "entersearch"
          "renametab"
          "renamepane"
        ];
        _children = [
          {
            bind = {
              _args = [ "esc" ];
              _children = [
                { SwitchToMode._args = [ "locked" ]; }
              ];
            };
          }
        ];
      };
    }
    {
      shared_except = {
        _args = [
          "locked"
          "entersearch"
          "renametab"
          "renamepane"
          "move"
        ];
        _children = [
          {
            bind = {
              _args = [ "m" ];
              _children = [
                { SwitchToMode._args = [ "move" ]; }
              ];
            };
          }
        ];
      };
    }
    {
      shared_except = {
        _args = [
          "locked"
          "entersearch"
          "search"
          "renametab"
          "renamepane"
          "session"
        ];
        _children = [
          {
            bind = {
              _args = [ "o" ];
              _children = [
                { SwitchToMode._args = [ "session" ]; }
              ];
            };
          }
        ];
      };
    }
    {
      shared_except = {
        _args = [
          "locked"
          "tab"
          "entersearch"
          "renametab"
          "renamepane"
        ];
        _children = [
          {
            bind = {
              _args = [ "t" ];
              _children = [
                { SwitchToMode._args = [ "tab" ]; }
              ];
            };
          }
        ];
      };
    }
    {
      shared_among = {
        _args = [
          "normal"
          "resize"
          "tab"
          "scroll"
          "prompt"
          "tmux"
        ];
        _children = [
          {
            bind = {
              _args = [ "p" ];
              _children = [
                { SwitchToMode._args = [ "pane" ]; }
              ];
            };
          }
        ];
      };
    }
    {
      shared_among = {
        _args = [
          "normal"
          "resize"
          "search"
          "move"
          "prompt"
          "tmux"
        ];
        _children = [
          {
            bind = {
              _args = [ "s" ];
              _children = [
                { SwitchToMode._args = [ "scroll" ]; }
              ];
            };
          }
        ];
      };
    }
    {
      shared_except = {
        _args = [
          "locked"
          "resize"
          "pane"
          "tab"
          "entersearch"
          "renametab"
          "renamepane"
        ];
        _children = [
          {
            bind = {
              _args = [ "r" ];
              _children = [
                { SwitchToMode._args = [ "resize" ]; }
              ];
            };
          }
        ];
      };
    }
  ];

in
{
  programs.zellij = {
    settings = {
      default_mode._args = [ "locked" ];

      plugins._children = [
        { about._props.location = "zellij:about"; }
        { compact-bar._props.location = "zellij:compact-bar"; }
        { configuration._props.location = "zellij:configuration"; }
        {
          filepicker = {
            _props.location = "zellij:strider";
            _children = [
              { cwd._args = [ "/" ]; }
            ];
          };
        }
        { plugin-manager._props.location = "zellij:plugin-manager"; }
        { session-manager._props.location = "zellij:session-manager"; }
        { status-bar._props.location = "zellij:status-bar"; }
        { strider._props.location = "zellij:strider"; }
        { tab-bar._props.location = "zellij:tab-bar"; }
        {
          welcome-screen = {
            _props.location = "zellij:session-manager";
            _children = [
              { welcome_screen._args = [ true ]; }
            ];
          };
        }
      ];

      keybinds._props.clear-defaults = true;

      keybinds.locked._children = [
        {
          bind = {
            _args = [ "Ctrl g" ];
            _children = [
              { SwitchToMode._args = [ "normal" ]; }
            ];
          };
        }
      ];

      keybinds.pane._children = paneBinds;

      keybinds._children = sharedBinds;
    };
  };
}
