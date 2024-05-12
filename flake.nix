{
  inputs.flake-utils.url = "github:numtide/flake-utils";

  outputs = { self, nixpkgs, flake-utils }:
    flake-utils.lib.eachDefaultSystem
      (system:
        let
          pkgs = nixpkgs.legacyPackages.${system};
        in
        {
          devShell = pkgs.mkShell {
            buildInputs = with pkgs; [
              # or you can use 'npx tree-sitter <command>'
              tree-sitter
              #
              # needed to build the grammar with 'tree-sitter generate'
              nodejs
              # needed to do gyp builds
              python3
              # compiles parser.c and other relavent c code in the grammar
              clang
              # for formatting grammar.js
              nodePackages.prettier
            ];
          };
        }
      );
}
