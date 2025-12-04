{ lib, ... }:
let
  flatten = list:
    builtins.concatMap
    (x:
      if builtins.isList x then
        flatten x
      else
        [ x ]
    )
    list;
in {
  inherit flatten;

	scanPaths = path:
		builtins.map
		(f: (path + "/${f}"))
		(builtins.attrNames
		  (lib.attrsets.filterAttrs
			(
			  path: _type:
				(_type == "directory") # include directories
				|| (
				  (path != "default.nix") # ignore default.nix
				  && (lib.strings.hasSuffix ".nix" path) # include .nix files
				)
			)
			(builtins.readDir path)));
}
