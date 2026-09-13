{ pkgs, ... }:

{
  home.activation.installAmp = pkgs.lib.hm.dag.entryAfter [ "writeBoundary" ] ''
    if [ ! -x "$HOME/.local/bin/amp" ]; then
      ${pkgs.curl}/bin/curl -fsSL https://ampcode.com/install.sh | ${pkgs.bash}/bin/bash
    fi
  '';

  home.sessionPath = [
    "$HOME/.local/bin"
  ];
}
