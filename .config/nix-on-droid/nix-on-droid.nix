{
  config,
  lib,
  pkgs,
  ...
}:

{
  android-integration.termux-setup-storage.enable = true;
  # Simply install just the packages
  environment.packages = builtins.attrValues {
    inherit (pkgs)
      git
      mc
      tmux
      findutils
      diffutils
      utillinux
      man
      gnutar
      zip
      unzip
      ;
      inherit (pkgs.haskellPackages) ghc hledger;
      emacs = (pkgs.emacsPackagesFor pkgs.emacs-nox).emacsWithPackages (
        epkgs:
        builtins.attrValues {
          inherit (epkgs.treesit-grammars) with-all-grammars;
        }
      );
  };

  terminal.colors = {
    background = "#FFFFFF";
    foreground = "#000000";
  };

  # Backup etc files instead of failing to activate generation if a file already exists in /etc
  environment.etcBackupExtension = ".bak";

  # Read the changelog before changing this value
  system.stateVersion = "24.05";

  # Set up nix for flakes
  nix.extraOptions = ''
    experimental-features = nix-command flakes
  '';

  # Set your time zone
  time.timeZone = "Europe/Berlin";
}
