{ config, lib, pkgs, ... }:
let
  desktopX = config.services.xserver.desktopManager;
  desktopW = config.services.desktopManager;

  askpass = if (desktopX.plasma5.enable) then
    "${pkgs.libsForQt5.ksshaskpass}/bin/ksshaskpass"
  else if (desktopW.plasma6.enable) then
    "${pkgs.kdePackages.ksshaskpass}/bin/ksshaskpass"
  else
    "${pkgs.x11_ssh_askpass}/libexec/x11-ssh-askpass";
in {
  # Enable the OpenSSH daemon
  services.openssh = {
    enable = true;
    settings = {
      #Harden
      PasswordAuthentication = false;
      PermitRootLogin = "no";
      # Automatically remove stale sockets
      StreamLocalBindUnlink = "yes";
    };
    # TODO sops this to accept keys
    # TODO set this up to reflect per-host 
    # TODO do the same for users
    extraConfig = ''
      HostCertificate /etc/ssh/ssh_host_ed25519_key-cert.pub
      TrustedUserCAKeys /etc/ssh/ca.pub
    '';
  };

  programs.ssh = {
    startAgent = true;
    # Allows PKCS11 Keys on Yubikey to be used for ssh authentication
    # agentPKCS11Whitelist = "${pkgs.opensc}/lib/opensc-pkcs11.so";
    askPassword = "${askpass}";
  };

  # Enforce askpass gui when the option is enabled (based on rather x11 is running)
  /* environment.sessionVariables =
     lib.mkIf (config.programs.ssh.enableAskPassword) {
       SSH_ASKPASS_REQUIRE = "prefer";
     };
  */
}
