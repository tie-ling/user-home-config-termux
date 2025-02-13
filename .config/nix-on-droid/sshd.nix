{config, pkgs,  ...}:
let
  sshdTmpDirectory = "${config.user.home}/.local/sshd-tmp";
  sshdDirectory = "${config.user.home}/.local/sshd";
  port = 8022;
in
{
  build.activation.sshd = ''
    if [[ ! -d "${sshdDirectory}" ]]; then
      $DRY_RUN_CMD rm $VERBOSE_ARG --recursive --force "${sshdTmpDirectory}"
      $DRY_RUN_CMD mkdir $VERBOSE_ARG --parents "${sshdTmpDirectory}"

      $VERBOSE_ECHO "Generating host keys..."
      $DRY_RUN_CMD ${pkgs.openssh}/bin/ssh-keygen -t ed25519 -f "${sshdTmpDirectory}/ssh_host_ed25519_key" -N ""

      $VERBOSE_ECHO "Writing sshd_config..."
      $DRY_RUN_CMD echo -e "HostKey ${sshdDirectory}/ssh_host_ed25519_key\nPort ${toString port}\n" > "${sshdTmpDirectory}/sshd_config"

      $DRY_RUN_CMD mv $VERBOSE_ARG "${sshdTmpDirectory}" "${sshdDirectory}"
    fi
  '';

  environment.packages = [
    (pkgs.writeScriptBin "sshd-start" ''
      #!${pkgs.runtimeShell}

      echo "Starting sshd in non-daemonized way on port ${toString port}"
      ${pkgs.openssh}/bin/sshd -f "${sshdDirectory}/sshd_config" -D
    '')
  ];
}