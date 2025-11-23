{
	description = "kb's systems";

	inputs = {
		nixpkgs.url = "nixpkgs/nixos-unstable";
		home-manager = {
			url = "github:nix-community/home-manager";
			inputs.nixpkgs.follows = "nixpkgs";
		};	
		nvf.url = "github:notashelf/nvf?ref=f8dc16a29f56d60ef7a8f2cf79a80b1ae441d452";
	};

	outputs = inputs@{ nixpkgs, home-manager, ... }: {
		nixosConfigurations.xps15 = nixpkgs.lib.nixosSystem {
			system = "x86_64-linux";
			specialArgs = { inherit inputs; };
			modules = [
				./xps15/configuration.nix
				home-manager.nixosModules.home-manager 
				{
					home-manager = {
            extraSpecialArgs = { inherit inputs; };
						useGlobalPkgs = true;
						useUserPackages = true;
						users.khanhbui.imports = [ ./home/xps15.nix ];
					};
				}
			];
		};
	};
}
