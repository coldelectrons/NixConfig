# This file defines overlays
{ outputs, inputs }:
let
  addPatches = pkg: patches:
    pkg.overrideAttrs
    (oldAttrs: { patches = (oldAttrs.patches or [ ]) ++ patches; });
in {
  # Third party overlays
  nur = inputs.nur.overlay;

  # For every flake input, aliases 'pkgs.inputs.${flake}' to
  # 'inputs.${flake}.packages.${pkgs.system}' or
  # 'inputs.${flake}.legacyPackages.${pkgs.system}'
  flake-inputs = final: _: {
    inputs = builtins.mapAttrs (_: flake:
      let
        legacyPackages = ((flake.legacyPackages or { }).${final.system} or { });
        packages = ((flake.packages or { }).${final.system} or { });
      in if legacyPackages != { } then legacyPackages else packages) inputs;
  };

  # This one brings our custom packages from the 'pkgs' directory
  additions = final: prev:
    import ../pkgs { pkgs = final; } // {
      #formats = prev.formats // import ../pkgs/formats { pkgs = final; };
      tmuxPlugins = prev.tmuxPlugins
        // final.callPackage ../pkgs/tmux-plugins { };
    };

       #   error: Python version mismatch in 'protontricks-1.11.1':

       # The Python derivation 'protontricks-1.11.1' depends on a Python derivation
       # named 'python3.12-vdf-3.4', but the two derivations use different versions
       # of Python:

       #     'protontricks-1.11.1' uses /nix/store/3wb0055984n2whn449hywsl4ag9gcjir-python3-3.11.9
       #      'python3.12-vdf-3.4' uses /nix/store/kqjp2f4zpqak97sy676san6np99613ff-python3-3.12.4

       # Possible solutions:

       #   * If 'python3.12-vdf-3.4' is a Python library, change the reference to 'python3.12-vdf-3.4'
       #     in the propagatedBuildInputs of 'protontricks-1.11.1' to use a 'python3.12-vdf-3.4' built from the same
       #     version of Python

       #   * If 'python3.12-vdf-3.4' is used as a tool during the build, move the reference to
       #     'python3.12-vdf-3.4' in 'protontricks-1.11.1' from propagatedBuildInputs to nativeBuildInputs

       #   * If 'python3.12-vdf-3.4' provides executables that are called at run time, pass its
       #     bin path to makeWrapperArgs:

       #         makeWrapperArgs = [ "--prefix PATH : ${lib.makeBinPath [ vdf ] }" ];
  # protontricks = final: prev: {
  #   protontricks =
  #     (prev.protontricks.overrideAttrs {
  #       src = final.fetchFromGitHub {
  #         owner = "Matoking";
  #         repo = "protontricks";
  #         rev = "f7b1fa33b0438dbd72f7222703f8442e40edc510";
  #         hash = "sha256-t794WEMJx/JNX3gTMHfgquFWB7yXkleW07+QURm1NPM=";
  #       };
  #     }).override {
  #       vdf = final.python311Packages.vdf.overrideAttrs {
  #         src = final.fetchFromGitHub {
  #           owner = "Matoking";
  #           repo = "vdf";
  #           rev = "981cad270c2558aeb8eccaf42cfcf9fabbbed199";
  #           hash = "sha256-OPonFrYrEFYtx0T2hvSYXl/idsm0iDPwqlnm1KbTPIo=";
  #         };
  #       };
  #     };
  # };

  # This one contains whatever you want to overlay
  # You can change versions, add patches, set compilation flags, anything really.
  # https://nixos.wiki/wiki/Overlays
  modifications = final: prev: {
    # example = prev.example.overrideAttrs (oldAttrs: rec {
    # ...
    # });

    vivaldi = prev.vivaldi.override {
      proprietaryCodecs = true;
      enableWidevine = true;
    };

    papirus-icon-theme = prev.papirus-icon-theme.override { color = "violet"; };

    tmux = prev.tmux.override {
      withSixel = true;
      withSystemd = true;
    };

    prismlauncher =
      prev.prismlauncher.override { withWaylandGLFW = true; };

    discord = prev.discord.override {
      withOpenASAR = true;
      withVencord = true;
    };

    protontricks-beta =
      (prev.protontricks.overrideAttrs {
        src = final.fetchFromGitHub {
          owner = "Matoking";
          repo = "protontricks";
          rev = "f7b1fa33b0438dbd72f7222703f8442e40edc510";
          hash = "sha256-t794WEMJx/JNX3gTMHfgquFWB7yXkleW07+QURm1NPM=";
        };
      }).override {
        vdf = final.python311Packages.vdf.overrideAttrs {
          src = final.fetchFromGitHub {
            owner = "Matoking";
            repo = "vdf";
            rev = "981cad270c2558aeb8eccaf42cfcf9fabbbed199";
            hash = "sha256-OPonFrYrEFYtx0T2hvSYXl/idsm0iDPwqlnm1KbTPIo=";
          };
        };
      };
  };
}
