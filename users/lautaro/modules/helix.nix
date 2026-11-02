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
        # Ported from the former Neovim LSP keymaps. Helix already binds
        # gd, Space-k, Space-r, and Space-a to these standard LSP actions.
        "gS" = "signature_help";

        space = {
          e = "diagnostics_picker";
          f.o = "format";
          g.d = [ "vsplit" "goto_definition" ];
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
