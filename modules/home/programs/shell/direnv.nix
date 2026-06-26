{ ... }:
{
  programs.direnv = {
    nix-direnv.enable = true;
    enableFishIntegration = true;
  };
}
