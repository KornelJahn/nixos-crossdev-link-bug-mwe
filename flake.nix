{
  description = "MWE for invalid cross-device link bug";

  inputs.nixpkgs.url = "github:nixos/nixpkgs/nixos-22.11";

  outputs = { self, nixpkgs, ... }:
    let
      system = "x86_64-linux";
      pkgs = nixpkgs.legacyPackages.${system};
    in
    {
      nixosConfigurations.nixos = nixpkgs.lib.nixosSystem {
        modules = [ ./configuration.nix ];
        specialArgs = { inherit self; };
      };

      formatter.${system} = pkgs.nixpkgs-fmt;

      packages.${system}.default = pkgs.writeShellApplication {
        name = "my-script";
        text = ''
          # NOTE: shellcheck should throw an error for this line!
          unused=
          echo 'Hello World!'
        '';
      };
    };
}
