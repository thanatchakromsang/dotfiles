{ config, pkgs, lib, ... }:

let
  defaultSettings = {
    "toolkit.legacyUserProfileCustomizations.stylesheets" = true;

    "extensions.autoDisableScopes" = 0;

    "browser.search.defaultenginename" = "Google";
    "browser.search.selectedEngine" = "Google";
    "browser.urlbar.placeholderName" = "Google";
    "browser.search.region" = "US";

    "browser.uidensity" = 1;
    "browser.search.openintab" = true;
    "xpinstall.signatures.required" = false;
    "extensions.update.enabled" = false;

    "browser.display.use_document_fonts" = true;
    "pdfjs.disabled" = true;
    "media.videocontrols.picture-in-picture.enabled" = true;

    "widget.non-native-theme.enabled" = false;

    "browser.startup.homepage" = "about:blank";

    "browser.newtabpage.activity-stream.feeds.telemetry" = false;
    "browser.newtabpage.activity-stream.telemetry" = false;
    "browser.ping-centre.telemetry" = false;
    "toolkit.telemetry.archive.enabled" = false;
    "toolkit.telemetry.bhrPing.enabled" = false;
    "toolkit.telemetry.enabled" = false;
    "toolkit.telemetry.firstShutdownPing.enabled" = false;
    "toolkit.telemetry.hybridContent.enabled" = false;
    "toolkit.telemetry.newProfilePing.enabled" = false;
    "toolkit.telemetry.reportingpolicy.firstRun" = false;
    "toolkit.telemetry.shutdownPingSender.enabled" = false;
    "toolkit.telemetry.unified" = false;
    "toolkit.telemetry.updatePing.enabled" = false;

    "experiments.activeExperiment" = false;
    "experiments.enabled" = false;
    "experiments.supported" = false;
    "network.allow-experiments" = false;
  };
  userChrome = ''
  '';
in
{
  home-manager.users.thanatchaya = {
    home.sessionVariables = {
      MOZ_ENABLE_WAYLAND = "1";
      XDG_CURRENT_DESKTOP = "sway";
    };

    programs.firefox = {
      enable = true;
      package = pkgs.firefox-wayland;
      profiles.personal = {
        id = 0;
        userChrome = userChrome;
        settings = defaultSettings;
      };
      profiles.work = {
        id = 1;
        userChrome = userChrome;
        settings = defaultSettings;
      };
      # https://github.com/nix-community/nur-combined/blob/master/repos/rycee/pkgs/firefox-addons/generated-firefox-addons.nix
      extensions = with pkgs.nur.repos.rycee.firefox-addons; [
        bitwarden
        tab-session-manager
        tree-style-tab
        darkreader
        grammarly
        i-dont-care-about-cookies
        refined-github
        ublock-origin
        # vimium
        tridactyl # vimium alternative
        # leechblock-ng
      ];
    };
  };
}
