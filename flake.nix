{
  description = "Example Darwin system flake";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixpkgs-unstable";
    nix-darwin.url = "github:LnL7/nix-darwin";
    nix-darwin.inputs.nixpkgs.follows = "nixpkgs";
    home-manager.url = "github:nix-community/home-manager";
    home-manager.inputs.nixpkgs.follows = "nixpkgs";
    nixvim.url = "github:nix-community/nixvim";
    nixvim.inputs.nixpkgs.follows = "nixpkgs";
  };

  outputs = inputs@{ self, nix-darwin, nixpkgs, home-manager, nixvim, ... }:
    let
      configuration = { pkgs, ... }: {
        # List packages installed in system profile. To search by name, run:
        # $ nix-env -qaP | grep wget
        environment.systemPackages = [ ];

        # Auto upgrade nix package and the daemon service.
        services.nix-daemon.enable = true;
        # nix.package = pkgs.nix;

        # Operating system
        system.defaults.NSGlobalDomain.AppleInterfaceStyle = "Dark";
        system.defaults.NSGlobalDomain.AppleInterfaceStyleSwitchesAutomatically = false;

        # yabai
        # system.defaults.spaces.spans-displays = false;
        # system.defaults.dock.mru-spaces = false;

        # services.yabai = {
        #   enable = true;

        #   config = {
        #     layout = "bsp";
        #     window_placement = "second_child";
        #     window_gap = 8;
        #     top_padding = 8;
        #     bottom_padding = 8;
        #     left_padding = 8;
        #     right_padding = 8;
        #     mouse_follows_focus = true;
        #   };

        #   extraConfig = ''
        #     yabai -m rule --add app="^Harvest$" manage=off
        #     yabai -m rule --add app="^Microsoft To Do$" manage=off

        #     yabai -m space 1 --label web
        #     # yabai -m rule --add app="^Microsoft Edge$" space=web

        #     yabai -m space 2 --label terminal
        #     yabai -m rule --add app="^iTerm2$" space=terminal

        #     yabai -m space 3 --label code
        #     yabai -m rule --add app="^Visual Studio Code$" space=code

        #     yabai -m space 4 --label work-comms
        #     yabai -m rule --add app="^Slack$" space=work-comms
        #     yabai -m rule --add app="^Microsoft Teams.*$" space=work-comms
        #     yabai -m rule --add app="^Microsoft Outlook$" space=work-comms

        #     yabai -m space 5 --label personal-comms
        #     yabai -m rule --add app="^Messages$" space=personal-comms
        #     yabai -m rule --add app="^Discord$" space=personal-comms

        #     yabai -m space 6 --label music
        #     yabai -m rule --add app="^Spotify$" space=music
        #     yabai -m rule --add app="^Music$" space=music
        #   '';
        # };

        # # skhd
        # services.skhd.enable = true;
        # services.skhd.skhdConfig = ''
        #   cmd + alt + ctrl - t : open -a "Microsoft To Do"
        # '';

        # Necessary for using flakes on this system.
        nix.settings.experimental-features = "nix-command flakes";

        # Create /etc/zshrc that loads the nix-darwin environment.
        programs.zsh.enable = true; # default shell on catalina
        # programs.fish.enable = true;

        # Set Git commit hash for darwin-version.
        system.configurationRevision = self.rev or self.dirtyRev or null;

        # Used for backwards compatibility, please read the changelog before changing.
        # $ darwin-rebuild changelog
        system.stateVersion = 4;

        # The platform the configuration will be used on.
        nixpkgs.hostPlatform = "aarch64-darwin";
        nixpkgs.config.allowUnfree = true;
        nixpkgs.overlays = [
          (import ./overlays/black.nix)
        ];

        # fonts to install
        fonts = {
          fontDir.enable = true;
          fonts = [
            pkgs.inter
            pkgs.fira-code
            # https://github.com/NixOS/nixpkgs/blob/master/pkgs/data/fonts/nerdfonts/shas.nix
            (pkgs.nerdfonts.override {
              fonts = [ "FiraCode" "CascadiaCode" "IBMPlexMono" ];
            })
          ];
        };

        homebrew = {
          enable = true;
          casks = [
            "iterm2"
            "obsidian"
          ];
        };

        users = {
          users = {
            mnaser = {
              home = "/Users/mnaser";
            };
          };
        };
      };
    in
    {
      # Build darwin flake using:
      # $ darwin-rebuild build --flake .#AMG
      darwinConfigurations."AMG" = nix-darwin.lib.darwinSystem {
        modules = [
          configuration
          home-manager.darwinModules.home-manager
          {
            home-manager.useGlobalPkgs = true;
            home-manager.useUserPackages = true;
            home-manager.users.mnaser = {
              imports = [
                ./systems/amg.nix
                ./home/default.nix
                ./home/gui.nix
                nixvim.homeManagerModules.nixvim
              ];
            };

            # Optionally, use home-manager.extraSpecialArgs to pass
            # arguments to home.nix
          }
        ];
      };

      # home-manager switch --flake .#devbox
      homeConfigurations = {
        ubuntu = home-manager.lib.homeManagerConfiguration {
          pkgs = import nixpkgs {
            system = "x86_64-linux";
            overlays = [
              (import ./overlays/black.nix)
            ];
          };

          modules = [
            ./systems/ubuntu.nix
            ./home/default.nix
            nixvim.homeManagerModules.nixvim
          ];
        };
      };

      # Expose the package set, including overlays, for convenience.
      darwinPackages = self.darwinConfigurations."AMG".pkgs;
    };
}
