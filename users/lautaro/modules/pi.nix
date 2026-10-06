{ inputs, pkgs, ... }:
{
  imports = [ inputs.pi.homeModules.default ];

  programs.pi.coding-agent = {
    enable = true;
    rules = "Be concise. I don't want the dirty fix first, my values align with correct and effective decisions";
    settings = {
      model = "gpt-6-luna";
    };
    jail = {
      enable = true;
      permissions = combinators: with combinators; [
        network
        mount-cwd

        (add-pkg-deps [
            pkgs.jq
            pkgs.gnumake
            pkgs.python3
        ])

        (try-readonly (noescape "~/.gitconfig"))
        ];
    };
  };
}
