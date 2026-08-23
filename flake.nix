{
  description = "syn-serde3 development shells";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-26.05-small";
    rust-overlay = {
      url = "github:oxalica/rust-overlay";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  outputs = { self, nixpkgs, rust-overlay }:
    let
      systems = [ "x86_64-linux" "aarch64-linux" "x86_64-darwin" "aarch64-darwin" ];
      forAllSystems = nixpkgs.lib.genAttrs systems;
    in
    {
      devShells = forAllSystems (system:
        let
          pkgs = import nixpkgs {
            inherit system;
            overlays = [ (import rust-overlay) ];
          };
          msrv = (builtins.fromTOML (builtins.readFile ./Cargo.toml)).package.rust-version;
        in
        {
          default = pkgs.mkShell {
            nativeBuildInputs = [
              pkgs.rust-bin.stable.latest.default
            ];
          };

          nightly = pkgs.mkShell {
            nativeBuildInputs = [
              pkgs.rust-bin.nightly.latest.default
            ];
          };

          msrv = pkgs.mkShell {
            nativeBuildInputs = [
              pkgs.rust-bin.stable.${msrv}.default
            ];
          };
        }
      );
    };
}
