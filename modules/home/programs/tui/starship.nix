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

  colors =
    config.background.colors.withHashtag
    |> (lib.filterAttrs (k: v: lib.isString v))
    |> camelAttrsToSnake;
in
{
  programs.starship.settings = {
    palettes.custom = colors;
    palette = "custom";

    add_newline = false;

    # Note that not all config and use, and only the ones in use works with the color system
    format = ''
      $cmd_duration$directory $git_branch
      ($username )$character
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
      truncation_length = 10;
      truncation_symbol = "";
      format = "• [](bold fg:primary)[$symbol $branch(:$remote_branch)](fg:on_primary bg:primary)[](bold fg:primary)";
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
      format = "[@$hostname](fg:primary)";
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
      style_user = "bold fg:primary";
      style_root = "bold fg:error";
      format = "[\\[$user\\]]($style)";
      disabled = false;
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
