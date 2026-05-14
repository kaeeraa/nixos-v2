{
  zen-browser,
  firefox-addons,
  system,
  ...
}: {
  imports = [
    zen-browser.homeModules.default
  ];
  programs.zen-browser = {
    enable = true;
    package = zen-browser.packages.${system}.default;

    policies = {
      DisableTelemetry = true;
      DisableFirefoxStudies = true;
      DisablePocket = true;
      DisableFirefoxAccounts = true;
      EnableTrackingProtection = {
        Value = true;
        Locked = false;
        Cryptomining = true;
        Fingerprinting = true;
        EmailTracking = true;
      };
      EncryptedMediaExtensions.Enabled = true;
      HardwareAcceleration = true;
      Preferences = {
        "browser.tabs.inTitlebar" = 1;
        "sidebar.verticalTabs" = true;
        "sidebar.revamp" = true;
        "zen.view.compact" = true;
        "zen.view.sidebar-expanded" = false;
        "zen.workspaces.enabled" = true;

        "browser.sessionstore.resume_from_crash" = true;
        "browser.cache.disk.enable" = true;
        "browser.cache.memory.enable" = true;

        "privacy.trackingprotection.enabled" = true;
        "privacy.resistFingerprinting" = false;
        "privacy.firstparty.isolate" = true;

        "browser.search.defaultenginename" = "DuckDuckGo";
        "browser.urlbar.defaultenginename" = "DuckDuckGo";
      };
    };

    profiles.kaeeraa = {
      id = 0;
      name = "kaeeraa";
      isDefault = true;

      extensions.packages = with firefox-addons.packages.${system}; [
        ublock-origin
        bitwarden
        darkreader
      ];

      settings = {
        "browser.toolbars.bookmarks.visibility" = "never";

        "browser.urlbar.suggest.engines" = true;
        "browser.urlbar.suggest.history" = true;
        "browser.urlbar.suggest.bookmark" = true;

        "browser.tabs.closeWindowWithLastTab" = false;
        "browser.tabs.warnOnClose" = false;
      };
    };
  };
  xdg.mimeApps = let
    value = let
      zen-browser = zen-browser.packages.${system}.default;
    in
      zen-browser.meta.desktopFileName;

    associations = builtins.listToAttrs (map (name: {
        inherit name value;
      }) [
        "application/x-extension-shtml"
        "application/x-extension-xhtml"
        "application/x-extension-html"
        "application/x-extension-xht"
        "application/x-extension-htm"
        "x-scheme-handler/unknown"
        "x-scheme-handler/mailto"
        "x-scheme-handler/chrome"
        "x-scheme-handler/about"
        "x-scheme-handler/https"
        "x-scheme-handler/http"
        "application/xhtml+xml"
        "application/json"
        "text/plain"
        "text/html"
      ]);
  in {
    associations.added = associations;
    defaultApplications = associations;
  };
}
