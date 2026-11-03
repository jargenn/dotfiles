{ ... }:
{
  programs.helix = {
    enable = true;

    settings = {
      theme = "gruvbox_dark_hard";

      editor = {
        mouse = true;
        line-number = "relative";
        cursorline = true;
        scrolloff = 4;
        rulers = [ 100 ];
        color-modes = true;
        completion-timeout = 5;
        auto-completion = true;
        auto-format = true;
        smart-tab.enable = true;
        indent-guides.render = true;
        soft-wrap.enable = false;
        end-of-line-diagnostics = "hint";
        inline-diagnostics.cursor-line = "warning";
        lsp.display-messages = true;
        lsp.display-inlay-hints = true;

        file-picker.hidden = false;
      };

      keys.normal = {
        "%" = "select_all";
        "A-k" = "move_line_up";
        "A-j" = "move_line_down";
        "A-up" = "jump_view_up";
        "A-down" = "jump_view_down";
        "A-left" = "jump_view_left";
        "A-right" = "jump_view_right";
        # LSP keymaps from 484f632, before their removal in c5743b7.
        # Helix has no direct workspace add/remove/list commands.
        K = "hover";
        g = {
          d = "goto_definition";
          S = "signature_help";
        };
        F8 = ":toggle lsp.display-inlay-hints";

        space = {
          e = "diagnostics_picker";
          a = "code_action";
          r.n = "rename_symbol";
          f.o = ":format";
          g.d = [
            "vsplit"
            "goto_definition"
          ];
        };
      };
    };

    languages = {
      language = [
        { name = "rust"; }
        { name = "c"; }
        { name = "typescript"; }
        { name = "css"; }
        { name = "djot"; }
        { name = "markdown"; }
        { name = "javascript"; }
        { name = "nix"; }
        { name = "sql"; }
        { name = "ocaml"; }
        { name = "python"; }
        { name = "lua"; }
      ];
    };
  };
}
