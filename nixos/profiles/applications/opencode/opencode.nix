{ config, pkgs, lib, ... }:

{
  home-manager.users.thanatchaya = { config, ... }: {
    # Symlink package.json, agents, skills, commands, and plugins directories for direct editing
    home.file.".config/opencode/package.json".source = config.lib.file.mkOutOfStoreSymlink "${config.home.homeDirectory}/.dotfiles/nixos/profiles/applications/opencode/package.json";
    home.file.".config/opencode/agents".source = config.lib.file.mkOutOfStoreSymlink "${config.home.homeDirectory}/.dotfiles/nixos/profiles/applications/opencode/agents";
    home.file.".config/opencode/skills".source = config.lib.file.mkOutOfStoreSymlink "${config.home.homeDirectory}/.dotfiles/nixos/profiles/applications/opencode/skills";
    home.file.".config/opencode/commands".source = config.lib.file.mkOutOfStoreSymlink "${config.home.homeDirectory}/.dotfiles/nixos/profiles/applications/opencode/commands";
    home.file.".config/opencode/plugins".source = config.lib.file.mkOutOfStoreSymlink "${config.home.homeDirectory}/.dotfiles/nixos/profiles/applications/opencode/plugins";

    programs.opencode = {
      enable = true;
      settings = {
        theme = "gruvbox";
        autoshare = false;
        autoupdate = false;

        # provider = {
        #   amazon-bedrock = {
        #     options = {
        #       region = "ap-southeast-1";
        #       profile = "";
        #     };
        #     # NOTE: Custom model because amazon-bedrock not have default global model
        #     models = {
        #       "global.anthropic.claude-opus-4-5-20251101-v1:0" = {
        #         name = "Claude Opus 4.5 (Best)";
        #       };
        #       "global.anthropic.claude-sonnet-4-5-20250929-v1:0" = {
        #         name = "Claude Sonnet 4.5 (Balanced)";
        #       };
        #       "global.anthropic.claude-haiku-4-5-20251001-v1:0" = {
        #         name = "Claude Haiku 4.5 (Fast)";
        #       };
        #     };
        #   };
        # };

        agent = {
          build = {
            mode = "primary";
            model = "deepseek-v4-flash-free";
            tools = {
              write = true;
              edit = true;
              bash = true;
            };
          };
          plan = {
            mode = "primary";
            model = "deepseek-v4-flash-free";
            tools = {
              write = false;
              edit = false;
              bash = false;
            };
          };
        };

        permission = {
          bash = {
            "*" = "allow";
          };
          edit = {
            "*" = "allow";
          };
          read = {
            "*" = "allow";
            "*.env" = "deny";
            "*.env.*" = "deny";
            "*.env.example" = "allow";
          };
        };
      };

      rules = ./opencode-memory.md;
    };
  };
}
