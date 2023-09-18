{
  description = "Automation for Fallen character sheet";

  outputs = { self, nixpkgs }:
  let
    system = "x86_64-linux";
    pkgs = import nixpkgs {
      inherit system;
    };
  in 
  {

    devShells.${system}.default = pkgs.mkShell rec {
      name = "FallenCharacterSheetAutomation";
      buildInputs = with pkgs; [
        dotnet-sdk_8
        gnome.gnome-terminal
        netcoredbg

        (vscode-with-extensions.override  {
          vscode = pkgs.vscode;
          vscodeExtensions = with pkgs.vscode-extensions; [
            ms-dotnettools.csharp
            jnoortheen.nix-ide
            ionide.ionide-fsharp
            mhutchie.git-graph
          ];
        })
      ];

      shellHook = ''
        export PS1+="${name}> "
        echo "Welcome to the Fallen Character Sheet Automation shell"
      '';
    };
  }; 

}

