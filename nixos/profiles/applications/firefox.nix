{ config, pkgs, lib, stable, ... }:

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

    "layout.css.prefers-color-scheme.content-override" = 1; # INFO: default to 3 (use browser theme text color), 1 will force light
  };
  userChrome = ''
    /* Source file https://github.com/MrOtherGuy/firefox-csshacks/tree/master/chrome/autohide_main_toolbar.css made available under Mozilla Public License v. 2.0
    See the above repository for updates as well as full license text. */

    /* This style hides the main toolbar and shows it when the cursor is over the tabs toolbar as well as whenever the focus is inside nav-bar, such as when urlbar is focused. */

    :root{ --uc-navbar-transform: -40px }
    :root[uidensity="compact"]{ --uc-navbar-transform: -34px }

    #navigator-toolbox > div{ display: contents; }
    :root[sessionrestored] :where(#nav-bar,#PersonalToolbar,#tab-notification-deck,.global-notificationbox){
      transform: translateY(var(--uc-navbar-transform))
    }
    :root:is([customizing],[chromehidden*="toolbar"]) :where(#nav-bar,#PersonalToolbar,#tab-notification-deck,.global-notificationbox){
      transform: none !important;
      opacity: 1 !important;
    }

    #nav-bar:not([customizing]){
      opacity: 0;
      transition:  transform 400ms ease 1.8s, opacity 400ms ease 1.8s !important;
      position: relative;
      z-index: 2;
    }
    #TabsToolbar{ position: relative; z-index: 3 }

    /* Show when toolbox is focused, like when urlbar has received focus */
    #navigator-toolbox:focus-within > .browser-toolbar{
      transform: translateY(0);
      opacity: 1;
      transition-duration: 500ms, 200ms !important;
      transition-delay: 0s !important;
    }
    /* Show when toolbox is hovered */
    #titlebar:hover ~ .browser-toolbar,
    #nav-bar:hover,
    #nav-bar:hover + #PersonalToolbar{
      transform: translateY(0);
      opacity: 1;
      transition-duration: 500ms, 200ms !important;
      transition-delay: 0s !important;
    }

    /* Bookmarks toolbar needs so extra rules */
    #PersonalToolbar{ transition: transform 400ms ease 1.8s !important; position: relative; z-index: 1 }

    /* Move up the content view */
    :root[sessionrestored]:not([inFullscreen]) > body > #browser{ margin-top: var(--uc-navbar-transform); }

    /* Source file https://github.com/MrOtherGuy/firefox-csshacks/tree/master/chrome/numbered_tabs.css made available under Mozilla Public License v. 2.0
    See the above repository for updates as well as full license text. */

    /* Show a number before tab text*/

    .tabbrowser-tab:first-child{ counter-reset: nth-tab 0 } /* Change to -1 for 0-indexing */
    .tab-text::before{ content: counter(nth-tab) ": "; counter-increment: nth-tab }

    /* "Better" default at bottom. */
    .tabbrowser-tab > .tab-stack > .tab-background > .tab-context-line
    {
      background-color: var(--identity-icon-color) !important;
      height: 2px !important;
      border-radius: 0px 0px var(--tab-border-radius) var(--tab-border-radius) !important;
      margin: 34px var(--tab-border-radius) 0px !important;
    }

    .tabbrowser-tab > .tab-stack > .tab-background
    {
        border-width: 0px !important;
    }
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
      /* INFO: Reverted to stable firefox due to https://github.com/NixOS/nixpkgs/issues/167785 */
      package = pkgs.stable.firefox-wayland.override {
        cfg = {
          enableTridactylNative = true;
        };
      };
      profiles.personal = {
        id = 0;
        userChrome = userChrome;
        settings = defaultSettings;
      };
      # https://github.com/nix-community/nur-combined/blob/master/repos/rycee/pkgs/firefox-addons/generated-firefox-addons.nix
      extensions = with pkgs.nur.repos.rycee.firefox-addons; [
        bitwarden
        darkreader
        ublock-origin
        multi-account-containers
        # vimium
        # tab-session-manager
        # tree-style-tab
        i-dont-care-about-cookies
        # refined-github
        tridactyl # vimium alternative
        leechblock-ng
      ];
    };

    xdg.configFile."tridactyl/tridactylrc".source = ./tridactylrc;
  };
}
