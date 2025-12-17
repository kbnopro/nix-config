{ config, lib, ... }:
let
  # For some idiotic reason, the camelCase naming doesnt work
  isUpper = c: c != lib.toLower c;

  camelToSnake =
    str:
    let
      chars = lib.stringToCharacters str;
      step = acc: c: if isUpper c then acc + "_" + lib.toLower c else acc + c;
      result = lib.foldl' step "" chars;
    in
    result;

  camelAttrsToSnake =
    attrs: lib.mapAttrs' (name: value: lib.nameValuePair (camelToSnake name) value) attrs;

  color =
    lib.removeAttrs config.background.color [
      "darkmode"
      "transparent"
    ]
    |> camelAttrsToSnake;
in
{
  programs.starship.settings = {
    palettes.custom = color;
    palette = "custom";

    add_newline = false;

    format = ''
      $cmd_duration$directory $git_branch
      $character
    '';

    character = {
      success_symbol = "[• ](bold fg:green) ";
      error_symbol = "[• 󰅙](bold fg:red) ";
    };

    package = {
      disabled = true;
    };

    git_branch = {
      style = "bg:primary";
      symbol = "󰘬";
      truncation_length = 4;
      truncation_symbol = "";
      format = "• [](bold fg:primary)[$symbol $branch(:$remote_branch)](fg:on_primary bg:primary)[ ](bold fg:primary)";
    };

    git_commit = {
      commit_hash_length = 4;
      tag_symbol = " ";
    };

    git_state = {
      format = ''[\($state( $progress_current of $progress_total)\)]($style) '';
      cherry_pick = "[🍒 PICKING](bold red)";
    };

    git_status = {
      conflicted = " 🏳 ";
      ahead = " 🏎💨 ";
      behind = " 😰 ";
      diverged = " 😵 ";
      untracked = " 🤷 ‍";
      stashed = " 📦 ";
      modified = " 📝 ";
      staged = ''[++\($count\)](green)'';
      renamed = " ✍️ ";
      deleted = " 🗑 ";
    };

    hostname = {
      ssh_only = false;
      format = "[•$hostname](bg:cyan bold fg:black)[](bold fg:cyan )";
      trim_at = ".companyname.com";
      disabled = false;
    };

    line_break = {
      disabled = false;
    };

    memory_usage = {
      disabled = true;
      threshold = -1;
      symbol = " ";
      style = "bold dimmed green";
    };

    time = {
      disabled = true;
      format = ''🕙[\[ $time \]]($style) '';
      time_format = "%T";
    };

    username = {
      style_user = "bold bg:cyan fg:black";
      style_root = "red bold";
      format = "[](bold fg:cyan)[$user]($style)";
      disabled = false;
      show_always = true;
    };

    directory = {
      home_symbol = "  ";
      read_only = "  ";
      style = "bg:primary fg:on_primary";
      truncation_length = 6;
      truncation_symbol = "••/";
      format = "[](bold fg:primary)[$path ]($style)[](bold fg:primary)";

      substitutions = {
        "Desktop" = "  ";
        "Documents" = "  ";
        "Downloads" = "  ";
        "Music" = " 󰎈 ";
        "Pictures" = "  ";
        "Videos" = "  ";
      };
    };

    cmd_duration = {
      min_time = 0;
      format = "[](bold fg:secondary)[ $duration](bold bg:secondary fg:on_secondary)[](bold fg:secondary) •• ";
    };
  };
}
