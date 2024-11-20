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
            noice-nvim
            nui-nvim
            nvim-notify
            yuck-vim
            rustaceanvim
            nvim-tree-lua
            nvim-treesitter.withAllGrammars
            luasnip # snippets | https://github.com/l3mon4d3/luasnip/
            nvim-cmp # https://github.com/hrsh7th/nvim-cmp
            cmp_luasnip # snippets autocompletion extension for nvim-cmp | https://github.com/saadparwaiz1/cmp_luasnip/
            lspkind-nvim # vscode-like LSP pictograms | https://github.com/onsails/lspkind.nvim/
            cmp-nvim-lsp # LSP as completion source | https://github.com/hrsh7th/cmp-nvim-lsp/
            cmp-nvim-lsp-signature-help # https://github.com/hrsh7th/cmp-nvim-lsp-signature-help/
            cmp-buffer # current buffer as completion source | https://github.com/hrsh7th/cmp-buffer/
            cmp-path # file paths as completion source | https://github.com/hrsh7th/cmp-path/
            cmp-nvim-lua # neovim lua API as completion source | https://github.com/hrsh7th/cmp-nvim-lua/
            cmp-cmdline # cmp command line suggestions
            cmp-cmdline-history # cmp command line history suggestions
# git integration plugins
            diffview-nvim # https://github.com/sindrets/diffview.nvim/
            gitsigns-nvim # https://github.com/lewis6991/gitsigns.nvim/
            vim-fugitive # https://github.com/tpope/vim-fugitive/
# telescope and extensions
            telescope-nvim # https://github.com/nvim-telescope/telescope.nvim/
            telescope-fzy-native-nvim # https://github.com/nvim-telescope/telescope-fzy-native.nvim
# UI
            lualine-nvim # Status line | https://github.com/nvim-lualine/lualine.nvim/
            nvim-navic # Add LSP location to lualine | https://github.com/SmiteshP/nvim-navic
            statuscol-nvim # Status column | https://github.com/luukvbaal/statuscol.nvim/
            nvim-treesitter-context # nvim-treesitter-context
# navigation/editing enhancement plugins
            vim-unimpaired # predefined ] and [ navigation keymaps | https://github.com/tpope/vim-unimpaired/
            eyeliner-nvim # Highlights unique characters for f/F and t/T motions | https://github.com/jinh0/eyeliner.nvim
            nvim-surround # https://github.com/kylechui/nvim-surround/
            nvim-treesitter-textobjects # https://github.com/nvim-treesitter/nvim-treesitter-textobjects/
            nvim-ts-context-commentstring # https://github.com/joosepalviste/nvim-ts-context-commentstring/
# Useful utilities
            nvim-unception # Prevent nested neovim sessions | nvim-unception
            which-key-nvim
# libraries that other plugins depend on
            sqlite-lua
            plenary-nvim
            nvim-web-devicons
            vim-repeat
# bleeding-edge plugins from flake inputs
            (mkNvimPlugin inputs.plugins-neogit "neogit")
            ];
      };

      optionalPlugins = {
        gitPlugins = with pkgs.neovimPlugins;
        [];
        general = with pkgs.vimPlugins; [
        ];
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
