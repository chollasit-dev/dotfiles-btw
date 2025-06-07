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
        # Package manager
        cargo
        corepack_latest

        # language related
        neovim
        nixd

        # devtool
        cloc
        bruno
        bruno-cli
        docker
        docker-buildx
        lazydocker
        litecli
        mongosh
        newman
        nodePackages_latest.vercel
        pgcli
        posting
        tig

        # WARN: not free
        ngrok
        postman

        # NOTE: current `yay` mirror URL not works
        btop
        fastfetch
        # btop-rocm # Conflict with standard `btop`
      ];
    };

    devShells.${arch}.default = pkgs.mkShell {
      buildInputs = with pkgs; [
        fastfetch
      ];
    };
  };
}
