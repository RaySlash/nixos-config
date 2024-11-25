# Copyright (c) 2023 BirdeeHub
# Licensed under the MIT license 

{ inputs, ... }@attrs:
let
  inherit (inputs) nixpkgs-unstable;
  inherit (inputs.nixCats) utils;
  nixpkgs = nixpkgs-unstable;
  luaPath = "${./.}";
  forEachSystem = utils.eachSystem nixpkgs.lib.platforms.all;
  extra_pkg_config = {
    # allowUnfree = true;
  };
  inherit (forEachSystem (system:
    let
      dependencyOverlays = # (import ./overlays inputs) ++
        [
          # see :help nixCats.flake.outputs.overlays
          (utils.standardPluginOverlay inputs)
        ];
    in { inherit dependencyOverlays; }))
    dependencyOverlays;

  categoryDefinitions =
    { pkgs, settings, categories, extra, name, mkNvimPlugin, ... }@packageDef: {

      lspsAndRuntimeDeps = { general = with pkgs; [ nil nixd stylua ]; };

      startupPlugins = {
        general = with pkgs.vimPlugins; [
          autoclose-nvim
          markdown-preview-nvim
          kanagawa-nvim
          nvim-colorizer-lua
          nui-nvim
          nvim-notify
          yuck-vim
          rustaceanvim
          nvim-tree-lua
          nvim-treesitter.withAllGrammars
          luasnip
          nvim-cmp
          cmp_luasnip
          lspkind-nvim
          cmp-nvim-lsp
          cmp-nvim-lsp-signature-help # https://github.com/hrsh7th/cmp-nvim-lsp-signature-help/
          cmp-buffer
          cmp-path
          cmp-nvim-lua
          cmp-cmdline
          cmp-cmdline-history
          # git integration plugins
          diffview-nvim
          gitsigns-nvim
          vim-fugitive
          # telescope and extensions
          telescope-nvim
          telescope-fzy-native-nvim
          # UI
          lualine-nvim
          nvim-navic
          statuscol-nvim
          nvim-treesitter-context
          # navigation/editing enhancement plugins
          vim-unimpaired
          eyeliner-nvim
          nvim-surround
          nvim-treesitter-textobjects
          nvim-ts-context-commentstring
          # Useful utilities
          nvim-unception
          which-key-nvim
          # libraries that other plugins depend on
          sqlite-lua
          plenary-nvim
          nvim-web-devicons
          vim-repeat
          # bleeding-edge plugins from flake inputs
          (mkNvimPlugin inputs.plugins-neogit "neogit")
          (mkNvimPlugin inputs.plugins-noice "noice")
        ];
      };

      optionalPlugins = {
        gitPlugins = with pkgs.neovimPlugins; [ ];
        general = with pkgs.vimPlugins; [ ];
      };

      sharedLibraries = { general = with pkgs; [ libgit2 ]; };

      environmentVariables = { test = { CATTESTVAR = "It worked!"; }; };

      extraWrapperArgs = {
        # https://github.com/NixOS/nixpkgs/blob/master/pkgs/build-support/setup-hooks/make-wrapper.sh
        test = [ ''--set CATTESTVAR2 "It worked again!"'' ];
      };

      extraPython3Packages = { test = (_: [ ]); };
      extraLuaPackages = { test = [ (_: [ ]) ]; };

    };

  packageDefinitions = {
    nvimcat = { pkgs, ... }: {
      # see :help nixCats.flake.outputs.settings
      settings = {
        wrapRc = true;
        aliases = [ "vim" "nvim" ];
        neovim-unwrapped =
          inputs.neovim-nightly-overlay.packages.${pkgs.system}.neovim;
      };
      categories = {
        general = true;
        test = true;
        example = {
          youCan = "add more than just booleans";
          toThisSet = [
            "and the contents of this categories set"
            "will be accessible to your lua with"
            "nixCats('path.to.value')"
            "see :help nixCats"
          ];
        };
      };
      extra = { };
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

    overlays = utils.makeOverlays luaPath {
      inherit nixpkgs dependencyOverlays extra_pkg_config;
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
