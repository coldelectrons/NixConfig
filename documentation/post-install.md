## Note
Some of these steps require an active internet connection! So it is recommended to have a place where you have stable internet before go through these steps.

## App Setup
Some apps may need additional commands to be ran in order to be fully functional.

### SteamVR
The vrcompositor for SteamVR requires superuser permissions to function properly, so you must run the following command prior to starting SteamVR:
```
setcap CAP_SYS_NICE+ep ~/.local/share/Steam/steamapps/common/SteamVR/bin/linux64/vrcompositor-launcher
```
This command is also included within the activation script under `hosts/common/optional/gaming.nix`. So all that would need to be ran is `home-manager switch --flake $FLAKE` (if using my config directly). This activation script may need to be ran again upon after installation since activation scripts do not function on installation.
