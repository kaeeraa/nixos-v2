{pkgs, ...}: {
  home.packages = [pkgs.gh];
  programs.delta = {
    enable = true;
    enableGitIntegration = true;
    options = {
      features = "decorations";
      line-numbers = true;
      side-by-side = true;
      hyperlinks = true;
      syntax-theme = "gruvbox-dark";
    };
  };
  programs.git = {
    enable = true;

    settings = {
      user.name = "kaeeraa";
      user.email = "kaeeraa@nebula-nook.ru";

      init.defaultBranch = "main";
      pull.rebase = true;
      push.autoSetupRemote = true;

      format.signoff = true;

      core = {
        editor = "nvim";
        pager = "delta";
        autocrlf = "input";
        safeDirectory = ["*" "/nix/store/*"];
      };

      color.ui = "auto";

      credential.helper = "libsecret";

      gpg.format = "ssh";
      user.signingKey = "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIMr8ke8Zj8UYXJqH98enTPmD8ENlhwewE4NcbLYAEQDF kaeeraa@desktop";
      commit.gpgSign = true;
      tag.gpgSign = true;

      alias = {
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
  };
}
