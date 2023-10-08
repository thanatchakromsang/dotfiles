{ config, pkgs, lib, ... }:

{
  home-manager.users.thanatchaya = { pkgs, ... }: {
    programs.git = {
      aliases = {
        mr = "push -o merge_request.create -o merge_request.remove_source_branch --set-upstream origin HEAD";
      };
      enable = true;
      userName = "Thanatchaya Kromsaeng";
      userEmail = "thanatchakromsang@gmail.com";
      extraConfig = {
        core = {
          sshCommand = "ssh -i ~/.ssh/personal.pri";
        };
        gpg = {
          format = "ssh";
        };
      };
      signing = {
        signByDefault = true;
        key = "~/.ssh/personal.pri";
      };
      includes = [
        {
          condition = "gitdir:~/Developers/abbon/";
          contents = {
            user = {
              email = "thanatchaya.kr@abbon.co.th";
              name = "Thanatchaya Kromsaeng";
            };
          };
        }
      ];
    };
  };
}
