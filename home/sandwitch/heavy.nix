{ config, lib, pkgs, inputs, ... }:

{
  imports = [
    ./global
    ./features/lunarvim
    ./features/cli
    # ./features/virt-manager
  ];

}
