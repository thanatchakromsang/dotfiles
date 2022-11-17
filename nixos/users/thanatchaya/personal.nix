{ config, pkgs, lib, ... }:

{
  home-manager.users.thanatchaya = { pkgs, ... }: {
    programs.git = {
      enable = true;
      userName = "Thanatchaya Kromsaeng";
      userEmail = "thanatchakromsang@gmail.com";
      extraConfig = {
        core = {
          sshCommand = "ssh -i ~/.ssh/personal.pri";
        };
      };
      signing = {
        signByDefault = true;
        key = "5254D8A1FBCE25D519C7E3D8E405CB1740495F06";
      };
      includes = [
        {
          condition = "gitdir:~/Developers/sertis/";
          contents = {
            user = {
              email = "tkrom@sertiscorp.com";
              name = "Thanatchaya Kromsaeng";
              signingKey = "5C0E779514D3F8218A58E627844EE25B2216DCDB";
            };
            core = {
              sshCommand = "ssh -i ~/.ssh/sertis.pri";
            };
            commit = {
              gpgSign = true;
            };
          };
        }
        {
          condition = "gitdir:~/Developers/sertis/scb/";
          contents = {
            user = {
              email = "aad.thanatchaya.kromsaeng@scb.co.th";
              name = "Thanatchaya Kromsaeng";
              signingKey = "5C0E779514D3F8218A58E627844EE25B2216DCDB";
            };
            core = {
              sshCommand = "ssh -i ~/.ssh/sertis.pri";
            };
            commit = {
              gpgSign = true;
            };
          };
        }
      ];
    };
  };
}
