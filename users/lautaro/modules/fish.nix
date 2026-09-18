{ ... }:

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

      nv = "nvim";
      l = "eza";
      ls = "eza";
      ll = "eza -l";
      lll = "eza -la";
      cd = "z";
    };

    interactiveShellInit = ''
      fish_vi_key_bindings

      fish_add_path $HOME/.cargo/bin
      fish_add_path $HOME/.amp/bin

      set -g fish_color_normal normal
      set -g fish_color_command blue
      set -g fish_color_keyword magenta
      set -g fish_color_quote green
      set -g fish_color_redirection cyan
      set -g fish_color_end green
      set -g fish_color_error red
      set -g fish_color_param cyan
      set -g fish_color_comment brblack
      set -g fish_color_operator yellow
      set -g fish_color_escape magenta
      set -g fish_color_autosuggestion brblack

      set -g fish_color_selection --reverse
      set -g fish_color_search_match --reverse

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
