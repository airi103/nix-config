{
  config,
  pkgs,
  lib,
  ...
}:

{
  programs.firefox = {
    enable = true;
    policies = {
      # Enable or disable automatic application update.
      AppAutoUpdate = true;
      # Configure cookie preferences.
      Cookies = {
        Allow = [
          "https://pinterest.com/"
          "https://github.com/"
          "https://reddit.com"
        ];
        Locked = true;
        Behavior = "reject-tracker-and-partition-foreign";
      };
      # Disable Firefox Accounts integration (Sync).
      DisableFirefoxAccounts = true;
      # Remove access to Firefox Screenshots.
      DisableFirefoxScreenshots = true;
      # Disable Firefox studies (Shield).
      DisableFirefoxStudies = true;
      # Remove Pocket in the Firefox UI.
      DisablePocket = true;
      # Disables the “Import data from another browser” option in the bookmarks window.
      DisableProfileImport = true;
      # Prevent the upload and local storage of telemetry data.
      DisableTelemetry = true;
      # Set the initial state of the bookmarks toolbar.
      DisplayBookmarksToolbar = "newtab";
      # Set the state of the menubar.
      DisplayMenuBar = "default-off";
      # Configure DNS over HTTPS.
      DNSOverHTTPS = {
        Enabled = true; # Determines whether DNS over HTTPS is enabled
        ProviderURL = "https://dns.quad9.net/dns-query"; # URL to another provider.
        Locked = true;
        Fallback = false; # Determines whether or not Firefox will use the default DNS resolver if there is a problem with the secure DNS provider.
      };
      # Configure tracking protection.
      EnableTrackingProtection = {
        Value = true; # Tracking protection is enabled by default in both the regular browser and private browsing
        Locked = true;
        Cryptomining = true; # Cryptomining scripts on websites are blocked.
        Fingerprinting = true; # Fingerprinting scripts on websites are blocked.
        EmailTracking = true; # Hidden email tracking pixels and scripts on websites are blocked.
      };
      # Encrypted media extensions (like Widevine) are not downloaded by Firefox unless the user consents to installing them.
      EncryptedMediaExtensions = {
        Enabled = true;
        Locked = true;
      };
      # Manage all aspects of extensions, reference: (https://mozilla.github.io/policy-templates/#extensionsettings).
      ExtensionSettings = {
        "*" = {
          blocked_install_message = "Extension Installation Blocked by the policies.";
          install_sources = [ "https://example.com/" ];
          installation_mode = "blocked";
          allowed_types = [ "extension" ];
        };
        "uBlock0@raymondhill.net" = {
          installation_mode = "force_installed";
          install_url = "https://addons.mozilla.org/firefox/downloads/latest/ublock-origin/latest.xpi";
        };
        "{20fc2e06-e3e4-4b2b-812b-ab431220cada}" = {
          installation_mode = "force_installed";
          install_url = "https://addons.mozilla.org/firefox/downloads/latest/startpage-private-search/latest.xpi";
        };
        "{446900e4-71c2-419f-a6a7-df9c091e268b}" = {
          installation_mode = "force_installed";
          install_url = "https://addons.mozilla.org/firefox/downloads/latest/bitwarden-password-manager/latest.xpi";
        };
      };
      # Control extension updates.
      ExtensionUpdate = true;
      # FirefoxHome
      FirefoxHome = {
        Search = true;
        TopSites = false;
        SponsoredTopSites = false;
        Highlights = false;
        Pocket = false;
        SponsoredPocket = false;
        Snippets = false;
        Locked = true;
      };
      # Control hardware acceleration.
      HardwareAcceleration = true;
      # Configure HTTPS-Only Mode.
      HttpsOnlyMode = "allowed";
      # Enable or disable network prediction (DNS prefetching).
      NetworkPrediction = true;
      # Enable or disable the New Tab page.
      NewTabPage = true;
      # Disable the creation of default bookmarks. (Only in effect if the user profile has not been created yet).
      NoDefaultBookmarks = true;
      # Control whether or not Firefox offers to save passwords.
      OfferToSaveLogins = false;
      # Clear data on shutdown.
      SanitizeOnShutdown = {
        Cache = true;
        Cookies = true;
        History = true;
        Sessions = true;
        SiteSettings = true;
        Locked = true;
      };
      # Prevent Firefox from messaging the user in certain situations.
      UserMessaging = {
        ExtensionRecommendations = false;
        FeatureRecommendations = false;
        UrlbarInterventions = false;
        SkipOnboarding = false;
        MoreFromMozilla = false;
        FirefoxLabs = false;
        Locked = true;
      };

      # Configure search engines.
      # SearchEngines = {
      #   Default = "Startpage"; # Set Startpage as default.
      #   Add = [
      #     {
      #       Name = "Startpage";
      #       URLTemplate = "https://startpage.com/sp/search?query={searchTerms}";
      #     }
      #     {
      #       Name = "SearXNG";
      #       UrlTemplate = "https://sx.catgirl.cloud/search?q={searchTerms}";
      #     }
      #   ];
      #   # Remove two of the built-in search engines.
      #   Remove = [ "Google" "Bing" ];
      #   LockDefault = true;
      # };

      # Set and lock preferences.
      # See https://mozilla.github.io/policy-templates/
      Preferences = {
        "geo.enabled" = {
          Value = false;
          Status = "default";
          Type = "boolean";
        };
        "geo.provider.use_geoclue" = {
          Value = false;
          Status = "default";
          Type = "boolean";
        };
        "geo.provider.geoclue.always_high_accuracy" = {
          Value = false;
          Status = "default";
          Type = "boolean";
        };
        "geo.prompt.open_system_prefs" = {
          Value = false;
          Status = "default";
          Type = "boolean";
        };
        "gfx.webrender.all" = {
          Value = true;
          Status = "default";
          Type = "boolean";
        };
        "gfx.font_rendering.cleartype_params.rendering_mode" = {
          Value = 5;
          Status = "default";
          Type = "integer";
        };
      };
    };
  };
}
