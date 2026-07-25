{
  description = "Lautaro Acosta Quintana's nix configuration.";

  inputs = {
    nixpkgs.url = "https://flakehub.com/f/NixOS/nixpkgs/0.1";
    home-manager = {
      url = "https://flakehub.com/f/nix-community/home-manager/0.1";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    nixpkgs-unstable.url = "https://flakehub.com/f/NixOS/nixpkgs/0.1";
    helix = {
      url = "github:helix-editor/helix";
      inputs.nixpkgs.follows = "nixpkgs-unstable";
    };
    jj-starship.url = "github:dmmulroy/jj-starship";
  };

  outputs =
    {
      self,
      nixpkgs,
      home-manager,
      jj-starship,
      ...
    }@inputs:
    let
      supportedSystems = [ "x86_64-linux" ];
      forAllSystems = f: nixpkgs.lib.genAttrs supportedSystems f;
    in
    {
      formatter = forAllSystems (system: nixpkgs.legacyPackages.${system}.nixfmt);

      homeConfigurations = {
        "lautaro" = home-manager.lib.homeManagerConfiguration {
          pkgs = import nixpkgs {
            system = "x86_64-linux";

            overlays = [
              jj-starship.overlays.default
            ];
          };

          extraSpecialArgs = {
            inherit inputs;
          };

          modules = [ ./users/lautaro/home.nix ];
        };
      };
    };
}
