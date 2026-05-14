{pkgs, ...}: {
  home.packages = [pkgs.gh];
  programs.git = {
    enable = true;
    userName = "kaeeraa";
    userEmail = "kaeeraa@nebula-nook.ru";

    delta = {
      enable = true;
      options = {
        features = "decorations";
        line-numbers = true;
        side-by-side = true;
        hyperlinks = true;
        syntax-theme = "gruvbox-dark";
      };
    };

    extraConfig = {
      init.defaultBranch = "main";
      pull.rebase = true;
      push.autoSetupRemote = true;

      core = {
        editor = "nvim";
        pager = "delta";
        autocrlf = "input";
        safeDirectory = ["*" "/nix/store/*"];
      };

      color.ui = "auto";

      credential.helper = "${pkgs.git-credential-libsecret}/bin/git-credential-libsecret";

      gpg.format = "ssh";
      user.signingKey = builtins.readFile ../secrets/public/git-signing.pub;
      commit.gpgSign = true;
      tag.gpgSign = true;
    };

    aliases = {
      st = "status -sb";
      co = "checkout";
      br = "branch";
      ci = "commit";
      lg = "log --graph --pretty=format:'%Cred%h%Creset -%C(yellow)%d%Creset %s %Cgreen(%cr) %C(bold blue)<%an>%Creset' --abbrev-commit";
      undo = "reset --soft HEAD^";
      amend = "commit --amend --no-edit";
      p = "push";
      pf = "push --force-with-lease";
      pu = "pull";
    };
  };
}
