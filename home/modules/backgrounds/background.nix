{ mylib, lib, ... }:

{
  options.background = {
    path = lib.mkOption {
      type = lib.types.path;
      default = mylib.relativeToRoot "home/background-images/cyan-moon.png";
    };
  };
}
