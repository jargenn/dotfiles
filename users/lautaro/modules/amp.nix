{
  config,
  lib,
  pkgs,
  ...
}:

{
  home.activation.installAmp = lib.hm.dag.entryAfter [ "writeBoundary" ] ''
    if [ ! -x "${config.home.homeDirectory}/.amp/bin/amp" ]; then
      PATH="${pkgs.curl}/bin:$PATH" \
        ${pkgs.curl}/bin/curl -fsSL https://ampcode.com/install.sh |
        PATH="${pkgs.curl}/bin:$PATH" \
          ${pkgs.bash}/bin/bash
    fi
  '';

  home.sessionPath = [
    "${config.home.homeDirectory}/.amp/bin"
  ];
}
