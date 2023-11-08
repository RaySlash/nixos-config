{ configs, pkgs, lib, ... }: {
 
  programs.firefox = {
    enable = true;
    profiles.smj = {
      name = "smj";
      isDefault = true;
      search.default = "DuckDuckGo";
      search.force = true;
      search.order = [
        "DuckDuckGo"
        "Google"
      ];
# For userchrome, set toolkit.legacyUserProfileCustomizations.stylesheets preference to true in about:config
      userChrome = builtins.readFile ./userChrome.css;
      userContent = builtins.readFile ./userContent.css;
      extensions = with pkgs.nur.repos.rycee.firefox-addons; [
        ublock-origin
        sidebery
        enhancer-for-youtube
        bitwarden
        darkreader
        privacy-badger
        firefox-color
      ];
    };
  };
}
