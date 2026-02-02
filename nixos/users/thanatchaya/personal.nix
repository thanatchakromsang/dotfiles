{ config, pkgs, lib, ... }:

{
  home-manager.users.thanatchaya = { pkgs, ... }: {
    programs.git = {
      enable = true;
      settings = {
        alias = {
          mr = "push -o merge_request.create -o merge_request.remove_source_branch --set-upstream origin HEAD";
        };
        user = {
          name = "Thanatchaya Kromsaeng";
          email = "thanatchakromsang@gmail.com";
        };
        core = {
          sshCommand = "ssh -i ~/.ssh/personal.pri";
          hooksPath = "git-hooks";
        };
        push = {
          default = "current";
        };
        pull = {
          rebase = true;
        };
        init = {
          defaultBranch = "main";
        };
        gpg = {
          format = "ssh";
        };
      };
      signing = {
        signByDefault = true;
        key = "~/.ssh/personal.pri";
      };
      # includes = [
      #   {
      #     condition = "gitdir:~/Developers/abbon/";
      #     contents = {
      #       user = {
      #         email = "thanatchaya.kr@abbon.co.th";
      #         name = "Thanatchaya Kromsaeng";
      #       };
      #     };
      #   }
      #   {
      #     condition = "gitdir:~/Developers/codemonday/";
      #     contents = {
      #       user = {
      #         email = "thanatchaya.k@codemonday.com";
      #         name = "Thanatchaya Pipe K.";
      #       };
      #     };
      #   }
      # ];
    };

    programs.gh = {
      enable = true;
      gitCredentialHelper = {
        enable = true;
        hosts = [
          "https://github.com"
          "https://gist.github.com"
        ];
      };

      settings = {
        git_protocol = "https";
        prompt = "enabled";
        co = "pr checkout";
        pv = "pr view";
      };
    };
  };
}
