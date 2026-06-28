{ pkgs, ... }:
{
  pythonEnv = pkgs.python312.withPackages (ps: [
    ps.materialyoucolor
    ps.pillow
  ]);
}
