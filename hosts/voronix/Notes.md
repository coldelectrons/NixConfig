## Klipper/Nix chicken/egg problem
There is a bit of friction using strictly NixOS with Klipper on a Pi-type SBC.

First, you need to have a Klipper firmware-config for the mcu controller(s),
in order to flash them. The generation of such a config is normally done __imperatively__
inside the `klipper` source code folder by running `make menuconfig`.
- _Note: this can be done with klipper-genconfig_

You have to flash the board with the Klipper firmware. This means it has to be build from that
config file. With USB you can at least specify the serial ID which becomes part of the
`/dev/serial/by-id/tty_Klipper_<mcu>_<serial_number>`. I haven't tried playing
around with CANBUS on NixOS, but I imagine there's a couple of extra steps.
Not the least of which there doesn't seem to be a way to set the CANBUS ID for a MCU,
so then it's also a couple steps to set up the CAN bus, and then use klipper script to 
query the bus for klipper instances, which gives you the IDs that need copied into
the Klippy config, and then do further configurin'.

(I also haven't yet tried to see what Klipperscreen needs.)

So, starting with a base SD, assuming it didn't have SSH enabled, you'll have
a *minimum* of 3 generations if everything went perfectly.

