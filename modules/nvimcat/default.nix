# Copyright (c) 2023 BirdeeHub
# Licensed under the MIT license
{inputs, ...} @ attrs: let
  inherit (inputs) nixpkgs-unstable;
  inherit (inputs.nixCats) utils;
  nixpkgs = nixpkgs-unstable;
  luaPath = "${./.}";
  forEachSystem = utils.eachSystem nixpkgs.lib.platforms.all;
  extra_pkg_config = {
    # allowUnfree = true;
  };
  inherit
    (forEachSystem (system: let
      dependencyOverlays =
        # (import ./overlays inputs) ++
        [
          # see :help nixCats.flake.outputs.overlays
          (utils.standardPluginOverlay inputs)
        ];
    in {inherit dependencyOverlays;}))
    dependencyOverlays
    ;

  categoryDefinitions = {
    pkgs,
    settings,
    categories,
    extra,
    name,
    mkNvimPlugin,
    ...
  } @ packageDef: {
    lspsAndRuntimeDeps = {
      general = with pkgs; [
        # Formatters
        alejandra
        clang-tools
        prettierd
        stylua
        rustfmt
        shfmt
        sql-formatter
        taplo
        # Lsp
        nil
        nixd
        rust-analyzer
        lua-language-server
        elmPackages.elm-language-server
        nodePackages.typescript-language-server
        zls
      ];
    };

    startupPlugins = {
      git = [
        (mkNvimPlugin inputs.plugins-neogit "neogit")
      ];
      lsp = with pkgs.vimPlugins; [
        markdown-preview-nvim
        formatter-nvim
        luasnip
        nvim-cmp
        cmp_luasnip
        lspkind-nvim
        nvim-ts-autotag
        cmp-nvim-lsp
        cmp-nvim-lsp-signature-help
        cmp-buffer
        cmp-path
        cmp-nvim-lua
        cmp-cmdline
        cmp-cmdline-history
        rustaceanvim
      ];
      ui = with pkgs.vimPlugins; [
        kanagawa-nvim
        lualine-nvim
        statuscol-nvim
        nvim-treesitter-context
        nvim-colorizer-lua
        neo-tree-nvim
      ];
      deps = with pkgs.vimPlugins; [
        sqlite-lua
        plenary-nvim
        nvim-web-devicons
        vim-repeat
      ];
      langs = with pkgs.vimPlugins; [
        nvim-treesitter.withAllGrammars
        yuck-vim
      ];
      general = with pkgs.vimPlugins; [
        autoclose-nvim
        flash-nvim
        telescope-nvim
        telescope-fzy-native-nvim
        vim-unimpaired
        eyeliner-nvim
        nvim-surround
        nvim-treesitter-textobjects
        nvim-ts-context-commentstring
        nvim-unception
        which-key-nvim
      ];
    };

    optionalPlugins = {
      gitPlugins = with pkgs.neovimPlugins; [];
      general = with pkgs.vimPlugins; [];
    };

    sharedLibraries = {general = with pkgs; [libgit2];};

    environmentVariables = {general = {EDITOR = "nvim";};};

    extraWrapperArgs = {
      # https://github.com/NixOS/nixpkgs/blob/master/pkgs/build-support/setup-hooks/make-wrapper.sh
      test = [''--set CATTESTVAR2 "It worked again!"''];
    };

    extraPython3Packages = {test = _: [];};
    extraLuaPackages = {test = [(_: [])];};
  };

  packageDefinitions = {
    nvimcat = {pkgs, ...}: {
      # see :help nixCats.flake.outputs.settings
      settings = {
        wrapRc = true;
        aliases = ["vi" "vim" "nvim"];
        neovim-unwrapped =
          inputs.neovim-nightly-overlay.packages.${pkgs.system}.default;
      };
      categories = {
        general = true;
        git = true;
        ui = true;
        lsp = true;
        deps = true;
        langs = true;
      };
      extra = {};
    };
  };
  defaultPackageName = "nvimcat";
  # see :help nixCats.flake.outputs.exports
in
  forEachSystem (system: let
    nixCatsBuilder =
      utils.baseBuilder luaPath {
        inherit system dependencyOverlays extra_pkg_config nixpkgs;
      }
      categoryDefinitions
      packageDefinitions;
    defaultPackage = nixCatsBuilder defaultPackageName;
    pkgs = import nixpkgs {inherit system;};
  in {
    packages = utils.mkAllWithDefault defaultPackage;

    devShells = {
      default = pkgs.mkShell {
        name = defaultPackageName;
        packages = [defaultPackage];
        inputsFrom = [];
        shellHook = "";
      };
    };
  })
  // {
    overlays =
      utils.makeOverlays luaPath {
        inherit nixpkgs dependencyOverlays extra_pkg_config;
      }
      categoryDefinitions
      packageDefinitions
      defaultPackageName;

    nixosModules.default = utils.mkNixosModules {
      inherit
        defaultPackageName
        dependencyOverlays
        luaPath
        categoryDefinitions
        packageDefinitions
        extra_pkg_config
        nixpkgs
        ;
    };
    homeModules.default = utils.mkHomeModules {
      inherit
        defaultPackageName
        dependencyOverlays
        luaPath
        categoryDefinitions
        packageDefinitions
        extra_pkg_config
        nixpkgs
        ;
    };
    inherit utils;
    inherit (utils) templates;
  }
