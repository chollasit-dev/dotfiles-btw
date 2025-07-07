{
  description = "My GTK debugger";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs?ref=nixos-unstable";
  };

  outputs = {nixpkgs, ...}: let
    pkgs = nixpkgs.legacyPackages.x86_64-linux;
  in {
    devShells.x86_64-linux.default = pkgs.mkShellNoCC {
      GTK_DEBUG = "interactive swaync";
      shellHook = ''
        /bin/zsh
      '';
    };
  };
}
