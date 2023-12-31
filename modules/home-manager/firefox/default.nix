{ config, lib, pkgs, inputs, ... }:
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
        "Google"
      ];
      userChrome = builtins.readFile ./userChrome.css;
      userContent = builtins.readFile ./userContent.css;
      settings = {
        "toolkit.legacyUserProfileCustomizations.stylesheets"  = true;
        "browser.bookmarks.restore_default_bookmarks" = false;
        "browser.ctrlTab.recentlyUsedOrder" = false;
        "browser.laterrun.enabled" = false;
        "browser.newtabpage.activity-stream.improvesearch.topSiteSearchShortcuts.havePinned" = "";
        "browser.newtabpage.activity-stream.improvesearch.topSiteSearchShortcuts.searchEngines" = "";
        "browser.newtabpage.activity-stream.section.highlights.includePocket" = false;
        "browser.newtabpage.pinned" = false;
        "browser.protections_panel.infoMessage.seen" = true;
        "browser.quitShortcut.disabled" = true;
        "browser.ssb.enabled" = true;
        "browser.toolbars.bookmarks.visibility" = "never";
        "browser.urlbar.placeholderName" = "DuckDuckGo";
        # https://raw.githubusercontent.com/pyllyukko/user.js/relaxed/user.js
        "dom.webnotifications.enabled" =			false;
        "dom.enable_performance" =				false;
        "dom.enable_user_timing" =				false;
        "dom.webaudio.enabled" =				false;
        "geo.enabled" =					false;
        "geo.wifi.uri" = "https://location.services.mozilla.com/v1/geolocate?key=%MOZILLA_API_KEY%";
        "geo.wifi.logging.enabled" = false;
        "dom.mozTCPSocket.enabled" =				false;
        "dom.storage.enabled" =		false;
        "dom.netinfo.enabled" =				false;
        "dom.network.enabled" =				false;
        "media.peerconnection.enabled" =			false;
        "media.peerconnection.ice.no_host" =			true; # Firefox >= 52
          "media.navigator.enabled" =				false;
        "media.navigator.video.enabled" =			false;
        "media.getusermedia.screensharing.enabled" =		false;
        "media.getusermedia.audiocapture.enabled" =		false;
        "dom.battery.enabled" =				false;
        "dom.telephony.enabled" =				false;
        "beacon.enabled" =					false;
        "media.webspeech.recognition.enable" =			false;
        "media.webspeech.synth.enabled" =			false;
        "device.sensors.enabled" =				false;
        "browser.send_pings" =					false;
        "browser.send_pings.require_same_host" =		true;
        "dom.gamepad.enabled" =				false;
        "dom.vr.enabled" =					false;
        "dom.vibrator.enabled" =           false;
        "dom.enable_resource_timing" =				false;
        "dom.archivereader.enabled" =				false;
        "webgl.disabled" =					true;
        "webgl.min_capability_mode" =				true;
        "webgl.disable-extensions" =				true;
        "webgl.disable-fail-if-major-performance-caveat" =	true;
        "webgl.enable-debug-renderer-info" =			false;
        "dom.maxHardwareConcurrency" =				2;
        "javascript.options.wasm" =				false;
        "camera.control.face_detection.enabled" =		false;
        "browser.search.countryCode" =				"US";
        "browser.search.region" =				"US";
        "browser.search.geoip.url" =				"";
        "intl.accept_languages" =				"en-US, en";
        "intl.locale.matchOS" =				false;
        "browser.search.geoSpecificDefaults" =			false;
        "clipboard.autocopy" =					false;
        "javascript.use_us_english_locale" =			true;
        "keyword.enabled" =					false;
        "browser.urlbar.trimURLs" =				false;
        "browser.fixup.alternate.enabled" =			false;
        "browser.fixup.hide_user_pass" = true;
        "network.proxy.socks_remote_dns" =			true;
        "network.manage-offline-status" =			false;
        "security.mixed_content.block_active_content" =	true;
        "network.jar.open-unsafe-types" =			false;
        "security.xpconnect.plugin.unrestricted" =		false;
        "security.fileuri.strict_origin_policy" =		true;
        "browser.urlbar.filter.javascript" =			true;
        "javascript.options.asmjs" =				false;
        "gfx.font_rendering.opentype_svg.enabled" =		false;
        "media.video_stats.enabled" =				false;
        "general.buildID.override" =				"20100101";
        "browser.startup.homepage_override.buildID" =		"20100101";
        "browser.display.use_document_fonts" =			0;
        "network.protocol-handler.warn-external-default" =	true;
        "network.protocol-handler.external.http" =		false;
        "network.protocol-handler.external.https" =		false;
        "network.protocol-handler.external.javascript" =	false;
        "network.protocol-handler.external.moz-extension" =	false;
        "network.protocol-handler.external.ftp" =		false;
        "network.protocol-handler.external.file" =		false;
        "network.protocol-handler.external.about" =		false;
        "network.protocol-handler.external.chrome" =		false;
        "network.protocol-handler.external.blob" =		false;
        "network.protocol-handler.external.data" =		false;
        "network.protocol-handler.expose-all" =		false;
        "network.protocol-handler.expose.http" =		true;
        "network.protocol-handler.expose.https" =		true;
        "network.protocol-handler.expose.javascript" =		true;
        "network.protocol-handler.expose.moz-extension" =	true;
        "network.protocol-handler.expose.ftp" =		true;
        "network.protocol-handler.expose.file" =		true;
        "network.protocol-handler.expose.about" =		true;
        "network.protocol-handler.expose.chrome" =		true;
        "network.protocol-handler.expose.blob" =		true;
        "network.protocol-handler.expose.data" =		true;
        "security.dialog_enable_delay" =			1000;
        "extensions.getAddons.cache.enabled" =			false;
        "lightweightThemes.update.enabled" =			false;
        "plugin.state.flash" =					0;
        "plugin.state.java" =					0;
        "dom.ipc.plugins.flash.subprocess.crashreporter.enabled" =	false;
        "dom.ipc.plugins.reportCrashURL" =			false;
        "browser.safebrowsing.blockedURIs.enabled" = true;
        "plugin.state.libgnome-shell-browser-plugin" =		0;
        "plugins.click_to_play" =				true;
        "extensions.update.enabled" =				false;
        "extensions.blocklist.enabled" =			true;
        "services.blocklist.update_enabled" =			true;
        "extensions.blocklist.url" =				"https://blocklist.addons.mozilla.org/blocklist/3/%APP_ID%/%APP_VERSION%/";
        "extensions.systemAddon.update.enabled" =		false;
        "browser.newtabpage.activity-stream.asrouter.userprefs.cfr" =	false;
        "network.trr.mode" =					0;
        "devtools.webide.enabled" =				false;
        "devtools.webide.autoinstallADBHelper" =		false;
        "devtools.webide.autoinstallFxdtAdapters" =		false;
        "devtools.debugger.remote-enabled" =			false;
        "devtools.chrome.enabled" =				false;
        "devtools.debugger.force-local" =			true;
        "toolkit.telemetry.enabled" =				false;
        "toolkit.telemetry.unified" =				false;
        "toolkit.telemetry.archive.enabled" =			false;
        "experiments.supported" =				false;
        "experiments.enabled" =				false;
        "experiments.manifest.uri" =				"";
        "network.allow-experiments" =				false;
        "breakpad.reportURL" =					"";
        "browser.tabs.crashReporting.sendReport" =		false;
        "browser.crashReports.unsubmittedCheck.enabled" =	false;
        "dom.flyweb.enabled" =					false;
        "browser.uitour.enabled" =				false;
        "privacy.trackingprotection.enabled" =			true;
        "privacy.trackingprotection.pbmode.enabled" =		true;
        "privacy.userContext.enabled" =			true;
        "privacy.resistFingerprinting" =			true;
        "privacy.resistFingerprinting.block_mozAddonManager" = true;
        "extensions.webextensions.restrictedDomains" = "";
        "browser.startup.blankWindow" = false;
        "pdfjs.disabled" =					false;
        "datareporting.healthreport.uploadEnabled" =		false;
        "datareporting.healthreport.service.enabled" =		false;
        "datareporting.policy.dataSubmissionEnabled" =		false;
        "browser.discovery.enabled" =				false;
        "app.normandy.enabled" = false;
        "app.normandy.api_url" = "";
        "extensions.shield-recipe-client.enabled" =		false;
        "app.shield.optoutstudies.enabled" =			false;
        "loop.logDomains" =					false;
        "app.update.auto" = false;
        "app.update.enabled" =                 false;
        "browser.safebrowsing.enabled" =			true; # Firefox < 50
          "browser.safebrowsing.phishing.enabled" =		true; # firefox >= 50
          "browser.safebrowsing.malware.enabled" =		true;
        "browser.safebrowsing.downloads.remote.enabled" =	false;
        "browser.pocket.enabled" =				false;
        "extensions.pocket.enabled" =				false;
        "browser.newtabpage.activity-stream.feeds.section.topstories" =	false;
        "network.http.keep-alive.timeout" =			15;
        "network.prefetch-next" =				false;
        "network.dns.disablePrefetch" =			true;
        "network.dns.disablePrefetchFromHTTPS" =		true;
        "network.predictor.enabled" =				false;
        "network.dns.blockDotOnion" =				true;
        "browser.search.suggest.enabled" =			false;
        "browser.urlbar.suggest.searches" =			false;
        "browser.urlbar.suggest.history" =			false;
        "browser.urlbar.groupLabels.enabled" = false; # Firefox >= 93
          "browser.casting.enabled" =				false;
        "media.gmp-gmpopenh264.enabled" =			false;
        "media.gmp-manager.url" =				"";
        "network.http.speculative-parallel-limit" =		0;
        "browser.aboutHomeSnippets.updateUrl" =		"";
        "browser.search.update" =				false;
        "network.captive-portal-service.enabled" =		false;
        "network.negotiate-auth.allow-insecure-ntlm-v1" =	false;
        "security.csp.experimentalEnabled" =			true;
        "security.csp.enable" =				true;
        "security.sri.enable" =				true;
        "privacy.donottrackheader.enabled" =		true;
        "network.cookie.cookieBehavior" =			1;
        "privacy.firstparty.isolate" =				true;
        "network.cookie.thirdparty.sessionOnly" =		true;
        "general.useragent.override" =				"Mozilla/5.0 (Windows NT 6.1; rv:45.0 Gecko/20100101 Firefox/45.0)";
        "general.appname.override" =				"Netscape";
        "general.appversion.override" =			"5.0 (Windows)";
        "general.platform.override" =				"Win32";
        "general.oscpu.override" =				"Windows NT 6.1";
        "browser.cache.offline.enable" =			true;
        "privacy.sanitize.timeSpan" =				0;
        "browser.cache.disk.enable" =				false;
        "browser.cache.disk_cache_ssl" =			false;
        "signon.rememberSignons" =				false;
        "network.cookie.lifetimePolicy" =			0;
        "signon.autofillForms" =				false;
        "signon.formlessCapture.enabled" =			false;
        "signon.autofillForms.http" =				false;
        "security.insecure_field_warning.contextual.enabled" = true;
        "browser.formfill.expire_days" =			0;
        "browser.sessionstore.privacy_level" =			2;
        "browser.helperApps.deleteTempFileOnExit" =		true;
        "browser.pagethumbnails.capturing_disabled" =		true;
        "browser.shell.shortcutFavicons" =					false;
        "browser.bookmarks.max_backups" = 0;
        "browser.chrome.site_icons" =				false;
        "security.insecure_password.ui.enabled" =		true;
        "identity.fxaccounts.enabled" = false;
        "browser.download.folderList" =			2;
        "browser.download.useDownloadDir" =			true;
        "browser.newtabpage.enabled" =				false;
        "browser.newtab.url" =					"about:blank";
        "browser.newtabpage.activity-stream.feeds.snippets" =	false;
        "browser.newtabpage.activity-stream.enabled" =		false;
        "browser.newtabpage.enhanced" =			false;
        "browser.newtab.preload" =				false;
        "browser.newtabpage.directory.ping" =			"";
        "browser.newtabpage.directory.source" =		"data:text/plain,{}";
        "plugins.update.notifyUser" =				true;
        "network.IDN_show_punycode" =				true;
        "browser.urlbar.autoFill" =				false;
        "browser.urlbar.autoFill.typed" =			false;
        "layout.css.visited_links_enabled" =			true;
        "browser.shell.checkDefaultBrowser" =			false;
        "security.ask_for_password" =				2;
        "security.password_lifetime" =				1;
        "browser.offline-apps.notify" =			true;
        "dom.security.https_only_mode" =			true;
        "network.stricttransportsecurity.preloadlist" =	true;
        "security.OCSP.enabled" =				1;
        "security.ssl.enable_ocsp_stapling" =			true;
        "security.ssl.enable_ocsp_must_staple" =		true;
        "security.OCSP.require" =				true;
        "security.ssl.disable_session_identifiers" =		true;
        "security.tls.version.min" =				3;
        "security.tls.version.max" =				4;
        "security.tls.version.fallback-limit" =		4;
        "security.cert_pinning.enforcement_level" =		2;
        "security.pki.sha1_enforcement_level" =		1;
        "security.ssl.treat_unsafe_negotiation_as_broken" =	true;
        "security.ssl.errorReporting.automatic" =		false;
        "browser.ssl_override_behavior" =			1;
        "network.security.esni.enabled" =			true;
        "security.ssl3.rsa_null_sha" =				false;
        "security.ssl3.rsa_null_md5" =				false;
        "security.ssl3.ecdhe_rsa_null_sha" =			false;
        "security.ssl3.ecdhe_ecdsa_null_sha" =			false;
        "security.ssl3.ecdh_rsa_null_sha" =			false;
        "security.ssl3.ecdh_ecdsa_null_sha" =			false;
        "security.ssl3.rsa_seed_sha" =				false;
        "security.ssl3.rsa_rc4_40_md5" =			false;
        "security.ssl3.rsa_rc2_40_md5" =			false;
        "security.ssl3.rsa_1024_rc4_56_sha" =			false;
        "security.ssl3.rsa_camellia_128_sha" =			false;
        "security.ssl3.ecdhe_rsa_aes_128_sha" =		false;
        "security.ssl3.ecdhe_ecdsa_aes_128_sha" =		false;
        "security.ssl3.ecdh_rsa_aes_128_sha" =			false;
        "security.ssl3.ecdh_ecdsa_aes_128_sha" =		false;
        "security.ssl3.dhe_rsa_camellia_128_sha" =		false;
        "security.ssl3.dhe_rsa_aes_128_sha" =			false;
        "security.ssl3.ecdh_ecdsa_rc4_128_sha" =		false;
        "security.ssl3.ecdh_rsa_rc4_128_sha" =			false;
        "security.ssl3.ecdhe_ecdsa_rc4_128_sha" =		false;
        "security.ssl3.ecdhe_rsa_rc4_128_sha" =		false;
        "security.ssl3.rsa_rc4_128_md5" =			false;
        "security.ssl3.rsa_rc4_128_sha" =			false;
        "security.tls.unrestricted_rc4_fallback" =		false;
        "security.ssl3.dhe_dss_des_ede3_sha" =			false;
        "security.ssl3.dhe_rsa_des_ede3_sha" =			false;
        "security.ssl3.ecdh_ecdsa_des_ede3_sha" =		false;
        "security.ssl3.ecdh_rsa_des_ede3_sha" =		false;
        "security.ssl3.ecdhe_ecdsa_des_ede3_sha" =		false;
        "security.ssl3.ecdhe_rsa_des_ede3_sha" =		false;
        "security.ssl3.rsa_des_ede3_sha" =			false;
        "security.ssl3.rsa_fips_des_ede3_sha" =		false;
        "security.ssl3.ecdh_rsa_aes_256_sha" =			false;
        "security.ssl3.ecdh_ecdsa_aes_256_sha" =		false;
        "security.ssl3.rsa_camellia_256_sha" =			false;
        "security.ssl3.ecdhe_ecdsa_aes_128_gcm_sha256" =	true; # 0xc02b
          "security.ssl3.ecdhe_rsa_aes_128_gcm_sha256" =		true; # 0xc02f
          "security.ssl3.ecdhe_ecdsa_chacha20_poly1305_sha256" =	true;
        "security.ssl3.ecdhe_rsa_chacha20_poly1305_sha256" =	true;
        "security.ssl3.dhe_rsa_camellia_256_sha" =		false;
        "security.ssl3.dhe_rsa_aes_256_sha" =			false;
        "security.ssl3.dhe_dss_aes_128_sha" =			false;
        "security.ssl3.dhe_dss_aes_256_sha" =			false;
        "security.ssl3.dhe_dss_camellia_128_sha" =		false;
        "security.ssl3.dhe_dss_camellia_256_sha" =		false;
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
};
}
