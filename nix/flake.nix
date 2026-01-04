{
  description = "Cereal flake btw, kickstarter for my daily driver btw";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs?ref=nixos-unstable";
  };

  outputs = {nixpkgs, ...}: let
    arch = "x86_64-linux";
    pkgs = nixpkgs.legacyPackages.${arch};
    langs = with pkgs; [nixd];
    tools = with pkgs; [
      cloc
      fastgron
      goose
      jqp
      lazydocker
      litecli
      pgcli
      posting
      sqlc
      tig
    ];
  in {
    packages.${arch} = rec {
      global_cereal = pkgs.buildEnv {
        name = "my-cereal-flake-btw";
        paths = langs ++ tools;
      };
      default = global_cereal;
    };
  };
}
