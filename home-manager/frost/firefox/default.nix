{ config, pkgs, lib, inputs, outputs, ... }: {
 
 imports = [
  inputs.arkenfox.hmModules.default
 ];
  programs.firefox = {
    enable = true;
    arkenfox = {
      enable = true;
      version = "master";
    };
    profiles.smj = {
      name = "smj";
      isDefault = true;
      search.default = "DuckDuckGo";
      search.force = true;
      search.order = [
        "DuckDuckGo"
        "Google"
      ];
      arkenfox = {
        enable = true;
        "0000".enable = true;
        "0100" = {
          enable = true;
          "0102"."browser.startup.page".value = 3;
          "0103"."browser.startup.homepage".value = "about:home";
        };
        "0200".enable = true;
        "0300".enable = true;
        "0400".enable = true;
        "0600".enable = true;
        "0700".enable = true;
        "0800" = {
          enable = true;
          "0807"."browser.urlbar.clipboard.featureGate".enable = true;
        };
        "0900".enable = true;
        "1000".enable = true;
        "1200".enable = true;
        "1600".enable = true;
        "1700".enable = true;
        "2000".enable = true;
        "2400".enable = true;
        "2600".enable = true;
        "2700".enable = true;
        "2800".enable = true;
        "4500" = {
          enable = true;
          "4504"."privacy.resistFingerprinting.letterboxing".enable = false;
          "4520"."webgl.disabled".enable = false;
        };
      };
      userChrome = builtins.readFile ./userChrome.css;
      userContent = builtins.readFile ./userContent.css;
      settings = {
        "toolkit.legacyUserProfileCustomizations.stylesheets" = true;
        "gfx.webrender.all" = true; # Force enable GPU acceleration
        "media.ffmpeg.vaapi.enabled" = true;
        "widget.dmabuf.force-enabled" = true; # Required in recent Firefoxes
        "ui.key.accelKey" = 91;
        "reader.parse-on-load.force-enabled" = true;
        "privacy.webrtc.legacyGlobalIndicator" = false;
        "app.update.auto" = false;
        "browser.bookmarks.restore_default_bookmarks" = false;
        "browser.ctrlTab.recentlyUsedOrder" = false;
        "browser.laterrun.enabled" = false;
        "browser.newtabpage.activity-stream.feeds.snippets" = false;
        "browser.newtabpage.activity-stream.improvesearch.topSiteSearchShortcuts.havePinned" = "";
        "browser.newtabpage.activity-stream.improvesearch.topSiteSearchShortcuts.searchEngines" = "";
        "browser.newtabpage.activity-stream.section.highlights.includePocket" = false;
        "browser.newtabpage.pinned" = false;
        "browser.protections_panel.infoMessage.seen" = true;
        "browser.quitShortcut.disabled" = true;
        "browser.shell.checkDefaultBrowser" = false;
        "browser.ssb.enabled" = true;
        "browser.toolbars.bookmarks.visibility" = "never";
        "browser.urlbar.placeholderName" = "DuckDuckGo";
        "browser.urlbar.suggest.openpage" = false;
        "extensions.pocket.enabled" = false;
        "identity.fxaccounts.enabled" = false;
      };
      extensions = with pkgs.nur.repos.rycee.firefox-addons; [
        ublock-origin
        sidebery
        enhancer-for-youtube
        bitwarden
        darkreader
        privacy-badger
        firefox-color
        gruvbox-dark-theme
        tridactyl
      ];
    };
  };
}
