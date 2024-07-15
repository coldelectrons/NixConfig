{ config, lib, pkgs, ... }:

{
  # Enable ALSA sound
  # sound.enable = true;

  # Disable PulseAudio
  hardware.pulseaudio.enable = lib.mkForce false;

  # Enable the RealtimeKit system service
  security.rtkit.enable = true;

  services.pipewire = {
    enable = true;
    alsa.enable = true;
    alsa.support32Bit = true;
    pulse.enable = true;
    jack.enable = true;
    wireplumber.enable = true;
    wireplumber.configPackages = [
      (pkgs.writeTextDir "share/wireplumber/bluetooth.lua.d/51-bluez-config.lua" ''
      bluez_monitor.properties = {
        ["bluez5.enable-sbc-xq"] = true,
        ["bluez5.enable-msbc"] = true,
        ["bluez5.enable-hw-volume"] = true,
        ["bluez5.headset-roles"] = "[ hsp_hs hsp_ag hfp_hf hfp_ag ]"
      }
      '')
    ];
    # services.pipewire.wireplumber.extraLuaConfig.bluetooth."51-bluez-config" = ''
    #   bluez_monitor.properties = {
    #     ["bluez5.enable-sbc-xq"] = true,
    #     ["bluez5.enable-msbc"] = true,
    #     ["bluez5.enable-hw-volume"] = true,
    #     ["bluez5.headset-roles"] = "[ hsp_hs hsp_ag hfp_hf hfp_ag ]"
    #   }
    # '';
    # use the example session manager (no others are packaged yet so this is enabled by default,
    # no need to redefine it in your config for now)
    #media-session.enable = true;
  };

  # Install audio configuration tools (Especially important for VR)
  environment.systemPackages = with pkgs; [ wireplumber pavucontrol pulseaudio ];
}
