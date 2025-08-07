{
  description = "Atomic Terraform IaC";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-24.05";
    flake-utils.url = "github:numtide/flake-utils";
  };

  outputs = { self, nixpkgs, flake-utils, ... }:
    flake-utils.lib.eachDefaultSystem (system:
      let
        pkgs = import nixpkgs {
          inherit system;

          config = {
            allowUnfree = true;
            allowUnfreePredicate = pkg:
              builtins.elem (pkgs.lib.getName pkg) [
                "terraform"
              ];
          };
        };
      in {
        devShells.default = pkgs.mkShell {
          name = "terraform-docker-shell";

          buildInputs = with pkgs; [
            terraform
            docker
            docker-compose
            git
          ];

          shellHook = ''
            echo "🚀 Welcome to your Terraform-Docker DevShell"
            echo "📦 Terraform: $(terraform version | head -n 1)"
            echo "🐳 Docker: $(docker --version)"
            echo "🧩 Compose: $(docker-compose --version)"
          '';
        };
      });
}
