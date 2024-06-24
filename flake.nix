{
  inputs = {
    devshell.url = "github:numtide/devshell";
    flake-parts.url = "github:hercules-ci/flake-parts";
    treefmt-nix.url = "github:numtide/treefmt-nix";
  };
  outputs = {
    self,
    nixpkgs,
    flake-parts,
    devshell,
    treefmt-nix,
    ...
  } @ inputs:
    flake-parts.lib.mkFlake {inherit inputs;} {
      imports = [
        devshell.flakeModule
        treefmt-nix.flakeModule
      ];

      systems = ["aarch64-linux" "x86_64-linux"];

      perSystem = {
        inputs',
        pkgs,
        ...
      }: {
        treefmt = {
          programs.alejandra.enable = true; # nix formatting
          programs.ruff.format = true; # python formatting
          flakeFormatter = true;
          projectRootFile = "flake.nix";
        };

        devshells.default = {pkgs, ...}: {
          commands = [
            {package = pkgs.sage;}
          ];
        };
      };
    };
}
