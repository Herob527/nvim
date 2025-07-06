{
  description = "Development environment";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";
    utils.url = "github:numtide/flake-utils";
  };

  outputs = { self, nixpkgs, utils }: 
    utils.lib.eachDefaultSystem (system:
      let
        pkgs = nixpkgs.legacyPackages.${system};
        python = pkgs.python3;
      in
      {
        devShell = pkgs.mkShell {
          buildInputs = [
            # Rust tools
            pkgs.cargo
            pkgs.cargo-binstall
            pkgs.fd
            pkgs.fzf
            
            # Go ecosystem
            pkgs.go_1_24
            pkgs.lazygit
            
            # Python ecosystem
            python
            python.pkgs.poetry
            
            # Java ecosystem
            pkgs.jdk
            
            # JavaScript ecosystem
            pkgs.nodejs_22
            
            # Zig ecosystem
            pkgs.zig
            
            # Development tools
            pkgs.neovim
            pkgs.git
            pkgs.yazi
          ];

          shellHook = ''
            export PATH="$PATH:${pkgs.python}/bin"
            
            # Setup idiomatic version files
            mkdir -p ./.tool-versions
            echo "node ${pkgs.nodejs_22.version}" > ./.tool-versions
            
            # Activate direnv
            source $HOME/.direnvrc
          '';
        };
      });
}
