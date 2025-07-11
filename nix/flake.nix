{
  description = "Cereal flake btw, kickstarter for my daily driver btw";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs?ref=nixos-unstable";
  };

  outputs = {nixpkgs, ...} @ inputs: let
    arch = "x86_64-linux";
    pkgs = nixpkgs.legacyPackages.${arch};
  in {
    packages.${arch}.default = pkgs.buildEnv {
      name = "my-cereal-flake-btw";
      paths = with pkgs; [
        # language related
        nixd

        # devtool
        cloc
        docker
        docker-buildx
        lazydocker
        litecli
        pgcli
        posting
        tig
      ];
    };
  };
}
