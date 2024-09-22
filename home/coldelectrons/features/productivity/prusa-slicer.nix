{ config, lib, pkgs, ... }:

{
  # xdg = {
  #   mimeApps = {
  #     associations = {
  #       added = {
  #         "x-scheme-handler/prusaslicer" = "PrusaSlicerURLProtocol.desktop";
  #         "model/stl" = "PrusaSlicer.desktop";
  #       };
  #     };
  #     defaultApplications = {
  #       "x-scheme-handler/prusaslicer" = "PrusaSlicerURLProtocol.desktop";
  #       "model/stl" = "PrusaSlicer.desktop";
  #     };
  #   };

  #   configFile = {
  #     "PrusaSlicer/printer" = {
  #       source = config.lib.file.mkOutOfStoreSymlink
  #         "${config.home.sessionVariables.FLAKE}/home/coldelectrons/dots/PrusaSlicer/printer";
  #       recursive = true;
  #     };
  #     "PrusaSlicer/print" = {
  #       source = config.lib.file.mkOutOfStoreSymlink
  #         "${config.home.sessionVariables.FLAKE}/home/coldelectrons/dots/PrusaSlicer/print";
  #       recursive = true;
  #     };
  #     "PrusaSlicer/physical_printer" = {
  #       source = config.lib.file.mkOutOfStoreSymlink
  #         "${config.home.sessionVariables.FLAKE}/home/coldelectrons/dots/PrusaSlicer/physical_printer";
  #       recursive = true;
  #     };
  #     "PrusaSlicer/filament" = {
  #       source = config.lib.file.mkOutOfStoreSymlink
  #         "${config.home.sessionVariables.FLAKE}/home/coldelectrons/dots/PrusaSlicer/filament";
  #       recursive = true;
  #     };
  #     "PrusaSlicer/bed_models" = {
  #       source = config.lib.file.mkOutOfStoreSymlink
  #         "${config.home.sessionVariables.FLAKE}/home/coldelectrons/dots/PrusaSlicer/bed_models";
  #       recursive = true;
  #     };
  #   };
  # };

  # home.packages = with pkgs; [ prusa-slicer ];
}
