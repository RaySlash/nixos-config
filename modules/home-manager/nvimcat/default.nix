# Copyright (c) 2023 BirdeeHub
# Licensed under the MIT license 

# myNixCats = import ./path/to/this/dir { inherit inputs; };
# And the new variable myNixCats will contain all outputs of the normal flake format.
# You could put myNixCats.packages.${pkgs.system}.thepackagename in your packages list.
# You could install them with the module and reconfigure them too if you want.
# You should definitely re export them under packages.${system}.packagenames
# from your system flake so that you can still run it via nix run from anywhere.
#
# The following is just the outputs function from the flake template.

{ inputs, ... }@attrs:
let
  inherit (inputs) nixpkgs; # <-- nixpkgs = inputs.nixpkgsSomething;
  inherit (inputs.nixCats) utils;
  luaPath = "${./.}";
  forEachSystem = utils.eachSystem nixpkgs.lib.platforms.all;
  extra_pkg_config = {
    # allowUnfree = true;
  };
  inherit (forEachSystem (system:
    let
      dependencyOverlays = (import inputs) ++ [
        # see :help nixCats.flake.outputs.overlays
        (utils.standardPluginOverlay inputs)
        inputs.neovim-nightly-overlay.overlays.default
        # add any flake overlays here.
      ];
    in { inherit dependencyOverlays; }))
    dependencyOverlays;

  categoryDefinitions = { pkgs, settings, categories, name, ... }@packageDef: {

    lspsAndRuntimeDeps = {
      general = with pkgs; [
        nodePackages.typescript-language-server
        nil
        nixd
        stylua
        elmPackages.elm-language-server
        haskell-language-server
        ccls
      ];
    };

    startupPlugins = {
      general = with pkgs.vimPlugins; [
        nui-nvim
        noice-nvim
        nvim-treesitter.withAllGrammars
        lualine-nvim
      ];
    };

    optionalPlugins = {
      gitPlugins = with pkgs.neovimPlugins; [ neogit ];
      general = with pkgs.vimPlugins; [
        kanagawa-nvim
        nvim-tree-lua
        telescope-nvim
        telescope-fzf-native-nvim
        plenary-nvim
        which-key-nvim
        nvim-web-devicons
        nvim-treesitter-context
        nvim-ts-context-commentstring
        nvim-surround
        nvim-navic
      ];
    };

    sharedLibraries = { general = with pkgs; [ libgit2 ]; };

    environmentVariables = { test = { CATTESTVAR = "It worked!"; }; };

    extraWrapperArgs = {
      # https://github.com/NixOS/nixpkgs/blob/master/pkgs/build-support/setup-hooks/make-wrapper.sh
      test = [ ''--set CATTESTVAR2 "It worked again!"'' ];
    };

    # lists of the functions you would have passed to
    # python.withPackages or lua.withPackages

    # get the path to this python environment
    # in your lua config via
    # vim.g.python3_host_prog
    # or run from nvim terminal via :!<packagename>-python3
    extraPython3Packages = { test = (_: [ ]); };
    # populates $LUA_PATH and $LUA_CPATH
    extraLuaPackages = { test = [ (_: [ ]) ]; };
    # extraNixdItems = pkgs: {
    #   nixpkgs = inputs.nixpkgsNV.outPath;
    #   flake-path = inputs.self.outPath;
    #   system = pkgs.stdenv.hostPlatform.system;
    #   systemCFGname = "smj@frost";
    #   homeCFGname = "smj@frost";
    # };
  };

  packageDefinitions = {
    nvimcat = { pkgs, ... }: {
      # they contain a settings set defined above
      # see :help nixCats.flake.outputs.settings
      settings = {
        wrapRc = true;
        # IMPORTANT:
        # your alias may not conflict with your other packages.
        aliases = [ "vim" "nvim" ];
        # neovim-unwrapped =
        #   inputs.neovim-nightly-overlay.packages.${pkgs.system}.neovim;
      };
      categories = {
        general = true;
        test = true;
      };
    };
  };

  defaultPackageName = "nvimcat";
  # see :help nixCats.flake.outputs.exports
in forEachSystem (system:
  let
    nixCatsBuilder = utils.baseBuilder luaPath {
      inherit system dependencyOverlays extra_pkg_config nixpkgs;
    } categoryDefinitions packageDefinitions;
    defaultPackage = nixCatsBuilder defaultPackageName;
    pkgs = import nixpkgs { inherit system; };
  in {
    packages = utils.mkAllWithDefault defaultPackage;

    devShells = {
      default = pkgs.mkShell {
        name = defaultPackageName;
        packages = [ defaultPackage ];
        inputsFrom = [ ];
        shellHook = "";
      };
    };

  }) // {

    # these outputs will be NOT wrapped with ${system}

    # this will make an overlay out of each of the packageDefinitions defined above
    # and set the default overlay to the one named here.
    overlays = utils.makeOverlays luaPath {
      # we pass in the things to make a pkgs variable to build nvim with later
      inherit nixpkgs dependencyOverlays extra_pkg_config;
      # and also our categoryDefinitions
    } categoryDefinitions packageDefinitions defaultPackageName;

    nixosModules.default = utils.mkNixosModules {
      inherit defaultPackageName dependencyOverlays luaPath categoryDefinitions
        packageDefinitions extra_pkg_config nixpkgs;
    };
    homeModule = utils.mkHomeModules {
      inherit defaultPackageName dependencyOverlays luaPath categoryDefinitions
        packageDefinitions extra_pkg_config nixpkgs;
    };
    inherit utils;
    inherit (utils) templates;
  }
