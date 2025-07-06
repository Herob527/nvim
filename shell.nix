{pkgs ? import <nixpkgs> {}}: let
  # Create a build environment that persists
  env = pkgs.buildEnv {
    name = "my-tools";
    paths = with pkgs; [
      nodejs
      neovim
    ];
  };
in
  env
