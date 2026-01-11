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

  mkNode = args: children: {
    _args = args;
    _children = children;
  };

  mkBind = key: children: { bind = mkNode [ key ] children; };

  mkAmong = modes: binds: { shared_among = mkNode modes binds; };
  mkExcept = modes: binds: { shared_except = mkNode modes binds; };

  paneBinds = [
    (mkBind "c" [
      { SwitchToMode = [ "renamepane" ]; }
      { PaneNameInput = [ 0 ]; }
    ])

    (mkBind "d" [
      { NewPane = [ "down" ]; }
      { SwitchToMode = [ "locked" ]; }
    ])

    (mkBind "e" [
      { TogglePaneEmbedOrFloating = [ ]; }
      { SwitchToMode = [ "locked" ]; }
    ])

    (mkBind "f" [
      { ToggleFocusFullscreen = [ ]; }
      { SwitchToMode = [ "locked" ]; }
    ])

    (mkBind "h" [
      { MoveFocus = [ "left" ]; }
    ])

    (mkBind "i" [
      { TogglePanePinned = [ ]; }
      { SwitchToMode = [ "locked" ]; }
    ])

    (mkBind "j" [
      { MoveFocus = [ "down" ]; }
    ])

    (mkBind "k" [
      { MoveFocus = [ "up" ]; }
    ])

    (mkBind "l" [
      { MoveFocus = [ "right" ]; }
    ])

    (mkBind "n" [
      { NewPane = [ ]; }
      { SwitchToMode = [ "locked" ]; }
    ])

    (mkBind "p" [
      { SwitchToMode = [ "normal" ]; }
    ])

    (mkBind "r" [
      { NewPane = [ "right" ]; }
      { SwitchToMode = [ "locked" ]; }
    ])

    (mkBind "s" [
      { NewPane = [ "stacked" ]; }
      { SwitchToMode = [ "locked" ]; }
    ])

    (mkBind "w" [
      { ToggleFloatingPanes = [ ]; }
      { SwitchToMode = [ "locked" ]; }
    ])

    (mkBind "x" [
      { CloseFocus = [ ]; }
      { SwitchToMode = [ "locked" ]; }
    ])

    (mkBind "z" [
      { TogglePaneFrames = [ ]; }
      { SwitchToMode = [ "locked" ]; }
    ])

    (mkBind "tab" [
      { SwitchFocus = [ ]; }
    ])

    (mkBind "left" [
      { MoveFocus = [ "left" ]; }
    ])

    (mkBind "down" [
      { MoveFocus = [ "down" ]; }
    ])

    (mkBind "up" [
      { MoveFocus = [ "up" ]; }
    ])

    (mkBind "right" [
      { MoveFocus = [ "right" ]; }
    ])
  ];

  tabBinds = [
    (mkBind "left" [ { GoToPreviousTab = [ ]; } ])
    (mkBind "down" [ { GoToNextTab = [ ]; } ])
    (mkBind "up" [ { GoToPreviousTab = [ ]; } ])
    (mkBind "right" [ { GoToNextTab = [ ]; } ])

    (mkBind "1" [
      { GoToTab = [ 1 ]; }
      { SwitchToMode = [ "locked" ]; }
    ])
    (mkBind "2" [
      { GoToTab = [ 2 ]; }
      { SwitchToMode = [ "locked" ]; }
    ])
    (mkBind "3" [
      { GoToTab = [ 3 ]; }
      { SwitchToMode = [ "locked" ]; }
    ])
    (mkBind "4" [
      { GoToTab = [ 4 ]; }
      { SwitchToMode = [ "locked" ]; }
    ])
    (mkBind "5" [
      { GoToTab = [ 5 ]; }
      { SwitchToMode = [ "locked" ]; }
    ])
    (mkBind "6" [
      { GoToTab = [ 6 ]; }
      { SwitchToMode = [ "locked" ]; }
    ])
    (mkBind "7" [
      { GoToTab = [ 7 ]; }
      { SwitchToMode = [ "locked" ]; }
    ])
    (mkBind "8" [
      { GoToTab = [ 8 ]; }
      { SwitchToMode = [ "locked" ]; }
    ])
    (mkBind "9" [
      { GoToTab = [ 9 ]; }
      { SwitchToMode = [ "locked" ]; }
    ])

    (mkBind "[" [
      { BreakPaneLeft = [ ]; }
      { SwitchToMode = [ "locked" ]; }
    ])
    (mkBind "]" [
      { BreakPaneRight = [ ]; }
      { SwitchToMode = [ "locked" ]; }
    ])
    (mkBind "b" [
      { BreakPane = [ ]; }
      { SwitchToMode = [ "locked" ]; }
    ])

    (mkBind "h" [ { GoToPreviousTab = [ ]; } ])
    (mkBind "j" [ { GoToNextTab = [ ]; } ])
    (mkBind "k" [ { GoToPreviousTab = [ ]; } ])
    (mkBind "l" [ { GoToNextTab = [ ]; } ])

    (mkBind "n" [
      { NewTab = [ ]; }
      { SwitchToMode = [ "locked" ]; }
    ])

    (mkBind "r" [
      { SwitchToMode = [ "renametab" ]; }
      { TabNameInput = [ 0 ]; }
    ])

    (mkBind "s" [
      { ToggleActiveSyncTab = [ ]; }
      { SwitchToMode = [ "locked" ]; }
    ])
    (mkBind "t" [ { SwitchToMode = [ "normal" ]; } ])
    (mkBind "x" [
      { CloseTab = [ ]; }
      { SwitchToMode = [ "locked" ]; }
    ])
    (mkBind "tab" [ { ToggleTab = [ ]; } ])
  ];

  resizeBinds = [
    (mkBind "left" [ { Resize = [ "Increase left" ]; } ])
    (mkBind "down" [ { Resize = [ "Increase down" ]; } ])
    (mkBind "up" [ { Resize = [ "Increase up" ]; } ])
    (mkBind "right" [ { Resize = [ "Increase right" ]; } ])

    (mkBind "+" [ { Resize = [ "Increase" ]; } ])
    (mkBind "-" [ { Resize = [ "Decrease" ]; } ])
    (mkBind "=" [ { Resize = [ "Increase" ]; } ])

    (mkBind "H" [ { Resize = [ "Decrease left" ]; } ])
    (mkBind "J" [ { Resize = [ "Decrease down" ]; } ])
    (mkBind "K" [ { Resize = [ "Decrease up" ]; } ])
    (mkBind "L" [ { Resize = [ "Decrease right" ]; } ])

    (mkBind "h" [ { Resize = [ "Increase left" ]; } ])
    (mkBind "j" [ { Resize = [ "Increase down" ]; } ])
    (mkBind "k" [ { Resize = [ "Increase up" ]; } ])
    (mkBind "l" [ { Resize = [ "Increase right" ]; } ])

    (mkBind "r" [ { SwitchToMode = [ "normal" ]; } ])
  ];

  moveBinds = [
    (mkBind "left" [ { MovePane = [ "left" ]; } ])
    (mkBind "down" [ { MovePane = [ "down" ]; } ])
    (mkBind "up" [ { MovePane = [ "up" ]; } ])
    (mkBind "right" [ { MovePane = [ "right" ]; } ])

    (mkBind "h" [ { MovePane = [ "left" ]; } ])
    (mkBind "j" [ { MovePane = [ "down" ]; } ])
    (mkBind "k" [ { MovePane = [ "up" ]; } ])
    (mkBind "l" [ { MovePane = [ "right" ]; } ])

    (mkBind "m" [ { SwitchToMode = [ "normal" ]; } ])
    (mkBind "n" [ { MovePane = [ ]; } ])
    (mkBind "p" [ { MovePaneBackwards = [ ]; } ])
    (mkBind "tab" [ { MovePane = [ ]; } ])
  ];

  scrollBinds = [
    (mkBind "Alt left" [
      { MoveFocusOrTab = [ "left" ]; }
      { SwitchToMode = [ "locked" ]; }
    ])
    (mkBind "Alt down" [
      { MoveFocus = [ "down" ]; }
      { SwitchToMode = [ "locked" ]; }
    ])
    (mkBind "Alt up" [
      { MoveFocus = [ "up" ]; }
      { SwitchToMode = [ "locked" ]; }
    ])
    (mkBind "Alt right" [
      { MoveFocusOrTab = [ "right" ]; }
      { SwitchToMode = [ "locked" ]; }
    ])

    (mkBind "e" [
      { EditScrollback = [ ]; }
      { SwitchToMode = [ "locked" ]; }
    ])

    (mkBind "f" [
      { SwitchToMode = [ "entersearch" ]; }
      { SearchInput = [ 0 ]; }
    ])

    (mkBind "Alt h" [
      { MoveFocusOrTab = [ "left" ]; }
      { SwitchToMode = [ "locked" ]; }
    ])
    (mkBind "Alt j" [
      { MoveFocus = [ "down" ]; }
      { SwitchToMode = [ "locked" ]; }
    ])
    (mkBind "Alt k" [
      { MoveFocus = [ "up" ]; }
      { SwitchToMode = [ "locked" ]; }
    ])
    (mkBind "Alt l" [
      { MoveFocusOrTab = [ "right" ]; }
      { SwitchToMode = [ "locked" ]; }
    ])

    (mkBind "s" [ { SwitchToMode = [ "normal" ]; } ])
  ];

  searchBinds = [
    (mkBind "c" [ { SearchToggleOption = [ "CaseSensitivity" ]; } ])
    (mkBind "n" [ { Search = [ "down" ]; } ])
    (mkBind "o" [ { SearchToggleOption = [ "WholeWord" ]; } ])
    (mkBind "p" [ { Search = [ "up" ]; } ])
    (mkBind "w" [ { SearchToggleOption = [ "Wrap" ]; } ])
  ];

  sessionBinds = [
    (mkBind "a" [
      {
        LaunchOrFocusPlugin =
          mkNode
            [ "zellij:about" ]
            [
              { floating = [ true ]; }
              { move_to_focused_tab = [ true ]; }
            ];
      }
      { SwitchToMode = [ "locked" ]; }
    ])

    (mkBind "c" [
      {
        LaunchOrFocusPlugin =
          mkNode
            [ "configuration" ]
            [
              { floating = [ true ]; }
              { move_to_focused_tab = [ true ]; }
            ];
      }
      { SwitchToMode = [ "locked" ]; }
    ])

    (mkBind "d" [ { Detach = [ ]; } ])
    (mkBind "o" [ { SwitchToMode = [ "normal" ]; } ])

    (mkBind "p" [
      {
        LaunchOrFocusPlugin =
          mkNode
            [ "plugin-manager" ]
            [
              { floating = [ true ]; }
              { move_to_focused_tab = [ true ]; }
            ];
      }
      { SwitchToMode = [ "locked" ]; }
    ])

    (mkBind "s" [
      {
        LaunchOrFocusPlugin =
          mkNode
            [ "zellij:share" ]
            [
              { floating = [ true ]; }
              { move_to_focused_tab = [ true ]; }
            ];
      }
      { SwitchToMode = [ "locked" ]; }
    ])

    (mkBind "w" [
      {
        LaunchOrFocusPlugin =
          mkNode
            [ "session-manager" ]
            [
              { floating = [ true ]; }
              { move_to_focused_tab = [ true ]; }
            ];
      }
      { SwitchToMode = [ "locked" ]; }
    ])
  ];

  sharedAmongBinds = [
    (mkAmong
      [ "normal" "locked" ]
      [
        (mkBind "Ctrl h" [
          {
            MessagePlugin =
              mkNode
                [ "file:${wasm}" ]
                [
                  {
                    name = [ "move_focus_or_tab" ];
                    payload = [ "left" ];
                  }
                ];
          }
        ])
        (mkBind "Ctrl j" [
          {
            MessagePlugin =
              mkNode
                [ "file:${wasm}" ]
                [
                  {
                    name = [ "move_focus" ];
                    payload = [ "down" ];
                  }
                ];
          }
        ])
        (mkBind "Ctrl k" [
          {
            MessagePlugin =
              mkNode
                [ "file:${wasm}" ]
                [
                  {
                    name = [ "move_focus" ];
                    payload = [ "up" ];
                  }
                ];
          }
        ])
        (mkBind "Ctrl l" [
          {
            MessagePlugin =
              mkNode
                [ "file:${wasm}" ]
                [
                  {
                    name = [ "move_focus_or_tab" ];
                    payload = [ "right" ];
                  }
                ];
          }
        ])

        (mkBind "Alt f" [ { ToggleFloatingPanes = [ ]; } ])
        (mkBind "Alt n" [ { NewPane = [ ]; } ])
        (mkBind "Alt p" [ { TogglePaneInGroup = [ ]; } ])
        (mkBind "Alt Shift p" [ { ToggleGroupMarking = [ ]; } ])
        (mkBind "Alt [" [ { PreviousSwapLayout = [ ]; } ])
        (mkBind "Alt ]" [ { NextSwapLayout = [ ]; } ])
      ]
    )

    (mkAmong
      [ "normal" "resize" "tab" "scroll" "prompt" "tmux" ]
      [
        (mkBind "p" [ { SwitchToMode = [ "pane" ]; } ])
      ]
    )

    (mkAmong
      [ "normal" "resize" "search" "move" "prompt" "tmux" ]
      [
        (mkBind "s" [ { SwitchToMode = [ "scroll" ]; } ])
      ]
    )
  ];

  sharedExceptBinds = [
    (mkExcept
      [ "locked" "renametab" "renamepane" ]
      [
        (mkBind "Ctrl g" [ { SwitchToMode = [ "locked" ]; } ])
        (mkBind "Ctrl q" [ { Quit = [ ]; } ])
      ]
    )

    (mkExcept
      [ "locked" "entersearch" ]
      [
        (mkBind "enter" [ { SwitchToMode = [ "locked" ]; } ])
      ]
    )

    (mkExcept
      [ "locked" "entersearch" "renametab" "renamepane" ]
      [
        (mkBind "esc" [ { SwitchToMode = [ "locked" ]; } ])
      ]
    )

    (mkExcept
      [ "locked" "entersearch" "renametab" "renamepane" "move" ]
      [
        (mkBind "m" [ { SwitchToMode = [ "move" ]; } ])
      ]
    )

    (mkExcept
      [ "locked" "entersearch" "search" "renametab" "renamepane" "session" ]
      [
        (mkBind "o" [ { SwitchToMode = [ "session" ]; } ])
      ]
    )

    (mkExcept
      [ "locked" "tab" "entersearch" "renametab" "renamepane" ]
      [
        (mkBind "t" [ { SwitchToMode = [ "tab" ]; } ])
      ]
    )

    (mkExcept
      [
        "locked"
        "resize"
        "pane"
        "tab"
        "entersearch"
        "renametab"
        "renamepane"
      ]
      [
        (mkBind "r" [ { SwitchToMode = [ "resize" ]; } ])
      ]
    )
  ];

  sharedBinds = sharedAmongBinds ++ sharedExceptBinds;

in
{
  programs.zellij = {
    settings = {
      default_mode._args = [ "locked" ];
      show_startup_tips = [ false ];

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

      keybinds.entersearch = {
        _children = [
          (mkBind "Ctrl c" [ { SwitchToMode = [ "scroll" ]; } ])
          (mkBind "esc" [ { SwitchToMode = [ "scroll" ]; } ])
          (mkBind "enter" [ { SwitchToMode = [ "search" ]; } ])
        ];
      };

      keybinds.renametab = {
        _children = [
          (mkBind "esc" [
            { UndoRenameTab = [ ]; }
            { SwitchToMode = [ "tab" ]; }
          ])
        ];
      };

      keybinds.renamepane = {
        _children = [
          (mkBind "esc" [
            { UndoRenamePane = [ ]; }
            { SwitchToMode = [ "pane" ]; }
          ])
        ];
      };

      sharedAmongBinds = [
        (mkAmong
          [ "renametab" "renamepane" ]
          [
            (mkBind "Ctrl c" [ { SwitchToMode = [ "locked" ]; } ])
          ]
        )
      ];

      keybinds.pane._children = paneBinds;

      keybinds.tab._children = tabBinds;

      keybinds.resize._children = resizeBinds;

      keybinds.move._children = moveBinds;

      keybinds.scroll._children = scrollBinds;

      keybinds.search._children = searchBinds;

      keybinds.session._children = sessionBinds;

      keybinds._children = sharedBinds;
    };
  };
}
