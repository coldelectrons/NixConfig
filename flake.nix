{
  # based largely on NovaViper and Misterio77 configs
  description = "My NixOS Configurations for multiple machines";

  inputs = {
    # Core dependencies
    nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";
    # nixpkgs-unstable.url = "github:nixos/nixpkgs/nixos-unstable";
    lix-module = {
      url = "https://git.lix.systems/lix-project/nixos-module/archive/2.90.0.tar.gz";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    hardware.url = "github:nixos/nixos-hardware";
    nur.url = "github:nix-community/NUR";
    sops-nix = {
      url = "github:mic92/sops-nix";
      inputs.nixpkgs.follows = "nixpkgs";
      inputs.nixpkgs-stable.follows = "nixpkgs";
    };
    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    # Extras
    # nixvim = {
    #   url = "github:nix-community/nixvim";
    #   inputs.nixpkgs.follows = "nixpkgs";
    # };
    nix-gaming = {
      # kept here for the improved Wine variants
      url = "github:fufexan/nix-gaming";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    plasma-manager = {
      url = "github:pjones/plasma-manager";
      inputs.nixpkgs.follows = "nixpkgs";
      inputs.home-manager.follows = "home-manager";
    };
    krunner-nix = {
      url = "github:pluiedev/krunner-nix";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    # wallpapers = {
    #   url = "github:NovaViper/Wallpapers";
    #   flake = false;
    # };
    
    # because protontricks magic number problem
    # https://github.com/Matoking/protontricks/issues/304
    protontricks = {
      url = "github:Matoking/protontricks/appinfo_v29";  
      flake = false;
    };
    vdf-patch = {
      url = "github:Matoking/vdf/support_new_bvdf";
      flake = false;
    };
  };

  outputs = { self, nixpkgs, lix-module, home-manager, ... }@inputs:
    let
      inherit (self) outputs;
      lib = nixpkgs.lib // home-manager.lib;
      # Supported systems for your flake packages, shell, etc.
      systems = [ "x86_64-linux" "aarch64-linux" ];
      # This is a function that generates an attribute by calling a function you pass to it, with each system as an argument
      forEachSystem = f: lib.genAttrs systems (system: f pkgsFor.${system});
      pkgsFor = lib.genAttrs systems (system:
        import nixpkgs {
          inherit system;
          overlays = [
            inputs.nur.overlay
          ];
          config = {
            allowUnfree = true;
            allowUnfreePredicate = (_: true);
            allowBroken = true;
          };
        });
    in {
      inherit lib;
      # Reusable nixos modules you might want to export
      # These are usually stuff you would upstream into nixpkgs
      nixosModules = import ./modules/nixos;
      # Reusable home-manager modules you might want to export
      # These are usually stuff you would upstream into home-manager
      homeManagerModules = import ./modules/home-manager;
      #templates = import ./templates;

      # Your custom packages and modifications, exported as overlays
      overlays = import ./overlays { inherit inputs outputs; };

      # Your custom packages
      # Acessible through 'nix build', 'nix shell', etc
      packages = forEachSystem (pkgs: import ./pkgs { inherit pkgs; });
      # Devshell for bootstrapping
      # Acessible through 'nix develop' or 'nix-shell' (legacy)
      devShells = forEachSystem (pkgs: import ./shell.nix { inherit pkgs; });
      # Formatter for your nix files, available through 'nix fmt'
      # Other options beside 'alejandra' include 'nixpkgs-fmt'
      formatter = forEachSystem (pkgs: pkgs.nixpkgs-fmt);

      # NixOS configuration entrypoint
      # Available through 'nixos-rebuild --flake .#your-hostname'
      nixosConfigurations = {
        # Main desktop
        hades = lib.nixosSystem {
          modules = [ 
            lix-module.nixosModules.default
            ./hosts/hades
          ];
          specialArgs = { inherit inputs outputs; };
        };
        # Personal laptop
        stickers = lib.nixosSystem {
          modules = [ 
            lix-module.nixosModules.default
            ./hosts/stickers
          ];
          specialArgs = { inherit inputs outputs; };
        };
        # server
        heavy = lib.nixosSystem {
          modules = [ 
            lix-module.nixosModules.default
            ./hosts/heavy
          ];
          specialArgs = { inherit inputs outputs; };
        };
        skinny = lib.nixosSystem {
          modules = [ 
            lix-module.nixosModules.default
            ./hosts/skinny
          ];
          specialArgs = { inherit inputs outputs; };
        };
        # rpi4-image = lib.nixosSystem {
        #   modules = [ 
        #     lix-module.nixosModules.default
        #     ./hosts/rpi4-image
        #   ];
        #   specialArgs = { inherit inputs outputs; };
        # };
        voronix = lib.nixosSystem {
          modules = [ 
            lix-module.nixosModules.default
            ./hosts/voronix
          ];
          specialArgs = { inherit inputs outputs; };
        };
        # leftarm = lib.nixosSystem {
        #   modules = [ 
        #     lix-module.nixosModules.default
        #     ./hosts/leftarm
        #   ];
        #   specialArgs = { inherit inputs outputs; };
        # };
        # rightarm = lib.nixosSystem {
        #   modules = [ 
        #     lix-module.nixosModules.default
        #     ./hosts/rightarm
        #   ];
        #   specialArgs = { inherit inputs outputs; };
        # };
        live-image = lib.nixosSystem {
          modules = [ 
            lix-module.nixosModules.default
            ./hosts/live-image
          ];
          specialArgs = { inherit inputs outputs; };
        };
      };

      # Standalone home-manager configuration entrypoint
      # Available through 'home-manager --flake .#your-username@your-hostname'
      homeConfigurations = {
        # desktops
        "coldelectrons@hades" = lib.homeManagerConfiguration {
          modules = [ 
            lix-module.nixosModules.default
            ./home/coldelectrons/hades.nix
          ];
          pkgs = pkgsFor.x86_64-linux;
          extraSpecialArgs = { inherit inputs outputs; };
        };
        # laptops
        "coldelectrons@stickers" = lib.homeManagerConfiguration {
          modules = [ 
            lix-module.nixosModules.default
            ./home/coldelectrons/stickers.nix
          ];
          pkgs = pkgsFor.x86_64-linux;
          extraSpecialArgs = { inherit inputs outputs; };
        };
        # servers
        "coldelectrons@heavy" = lib.homeManagerConfiguration {
          modules = [ 
            lix-module.nixosModules.default
            ./home/coldelectrons/heavy.nix
          ];
          pkgs = pkgsFor.x86_64-linux;
          extraSpecialArgs = { inherit inputs outputs; };
        };
      };
    };
}
