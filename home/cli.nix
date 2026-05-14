{lib, ...}: {
  programs.zoxide.enable = true;
  programs.zsh = {
    enable = true;
    autocd = true;

    syntaxHighlighting = {
      enable = true;
      highlighters = ["main" "brackets"];
    };

    autosuggestion = {
      enable = true;
      strategy = ["match_prev_cmd" "history" "completion"];
    };

    history.append = true;
    historySubstringSearch.enable = true;

    initContent = lib.mkBefore ''
      setopt interactive_comments
    '';
  };
}
