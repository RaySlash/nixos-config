{ config, lib, pkgs, ... }:
let
  inherit (lib) mkEnableOption mkIf;
  cfg = config.services.hardened-firefox;
in {

  options.services.hardened-firefox = {
    enable = mkEnableOption "hardened-firefox";
  };

  config = mkIf cfg.enable {

  programs.firefox = {
    enable = true;
    profiles.smj = {
      name = "smj";
      isDefault = true;
      search.default = "DuckDuckGo";
      search.force = true;
      search.order = [
        "DuckDuckGo"
      ];
      userChrome = builtins.readFile ./userChrome.css;
      userContent = builtins.readFile ./userContent.css;
      settings = {
        "app.update.auto" = false;
        "app.update.enabled" = false;
        "toolkit.legacyUserProfileCustomizations.stylesheets" = true;
        "browser.bookmarks.restore_default_bookmarks" = false;
        "browser.ctrlTab.recentlyUsedOrder" = false;
        "browser.laterrun.enabled" = false;
        "browser.newtabpage.activity-stream.section.highlights.includePocket" = false;
        "browser.newtabpage.pinned" = false;
        "browser.protections_panel.infoMessage.seen" = true;
        "browser.quitShortcut.disabled" = true;
        "browser.ssb.enabled" = true;
        "browser.urlbar.placeholderName" = "DuckDuckGo";
        "browser.pocket.enabled" = false;
        "extensions.pocket.enabled" = false;
        "identity.fxaccounts.enabled" = false;
        "privacy.trackingprotection.enabled" = true;
        "privacy.trackingprotection.pbmode.enabled" = true;
        "privacy.userContext.enabled" = true;
        "privacy.resistFingerprinting" = true;
        "privacy.resistFingerprinting.block_mozAddonManager" = true;
        "extensions.update.enabled" = false;
        "extensions.systemAddon.update.enabled" = false;
        "browser.newtabpage.activity-stream.asrouter.userprefs.cfr" = false;
        "network.trr.mode" = 0;
        "devtools.webide.enabled" = false;
        "devtools.webide.autoinstallADBHelper" = false;
        "devtools.webide.autoinstallFxdtAdapters" = false;
        "devtools.debugger.remote-enabled" = false;
        "devtools.chrome.enabled" = false;
        "devtools.debugger.force-local" = true;
        "toolkit.telemetry.enabled" = false;
        "toolkit.telemetry.unified" = false;
        "toolkit.telemetry.archive.enabled" = false;
        "experiments.supported" = false;
        "experiments.enabled" = false;
        "experiments.manifest.uri" = "";
        "network.allow-experiments" = false;
        "breakpad.reportURL" = "";
        "browser.tabs.crashReporting.sendReport" = false;
        "browser.crashReports.unsubmittedCheck.enabled" = false;
        "dom.flyweb.enabled" = false;
        "browser.uitour.enabled" = false;
        "datareporting.healthreport.uploadEnabled" = false;
        "datareporting.healthreport.service.enabled" = false;
        "datareporting.policy.dataSubmissionEnabled" = false;
        "browser.discovery.enabled" = false;
        "app.normandy.enabled" = false;
        "app.normandy.api_url" = "";
        "extensions.shield-recipe-client.enabled" = false;
        "app.shield.optoutstudies.enabled" = false;
        "security.csp.experimentalEnabled" = true;
        "security.csp.enable" =	true;
        "security.sri.enable" = true;
        "privacy.donottrackheader.enabled" = true;
        "network.cookie.cookieBehavior" = 1;
        "privacy.firstparty.isolate" = true;
        "network.cookie.thirdparty.sessionOnly" = true;
        "browser.cache.offline.enable" = true;
        "browser.download.folderList" = 2;
        "browser.download.useDownloadDir" = true;
        "browser.newtabpage.enabled" = false;
        "browser.newtab.url" = "about:blank";
        "browser.newtabpage.activity-stream.feeds.snippets" = false;
        "browser.newtabpage.activity-stream.enabled" = false;
        "browser.newtabpage.enhanced" = false;
        "browser.newtab.preload" = false;
        "browser.newtabpage.directory.ping" = "";
        "browser.newtabpage.directory.source" = "data:text/plain,{}";
        "plugins.update.notifyUser" = true;
      };
      extensions = with pkgs.nur.repos.rycee.firefox-addons; [
        tridactyl
        sidebery
        ublock-origin
        bitwarden
        darkreader
        privacy-badger
        firefox-color
        gruvbox-dark-theme
        enhancer-for-youtube
        sponsorblock
        redirector
      ];
    };
  };
};
}
