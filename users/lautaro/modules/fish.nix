{ pkgs, ... }:

{
  programs.fish = {
    enable = true;

    shellAbbrs = {
      c = "cargo";
      m = "make";
      g = "git";
      k = "kubectl";

      ga = "git add";
      glr = "pretty_git_log";
      co = "git checkout";
      gap = "git add -p";
      gc = "git commit";
      gd = "git diff";
      gs = "git status";
      gp = "git push";
      gl = "git dl";

      tma = "tmux attach";

      j = "jj";
      jjj = "jj";
      js = "jj status";
      jd = "jj diff";
      jn = "jj new";
      jsm = "jj bookmark set main";
      jh = "jj log -r 'heads(all())'";
      jt = "jj log -r 'tags()'";
      jjp = "jj git push";

      l = "eza";
      ls = "eza";
      ll = "eza -l";
      lll = "eza -la";
      cd = "z";
    };

    interactiveShellInit = ''
      fish_vi_key_bindings

      fish_add_path $HOME/.cargo/bin

      ${builtins.readFile ./fns.fish}
    '';
  };

  programs.atuin = {
    enable = true;
    enableFishIntegration = true;
  };

  programs.zoxide = {
    enable = true;
    enableFishIntegration = true;
  };
}

