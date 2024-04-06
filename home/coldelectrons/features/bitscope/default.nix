{ pkgs, ... }:
{
  home.packages = with pkgs; [
    bitscope.dso
    bitscope.server
    bitscope.proto
    bitscope.logic
    bitscope.meter
    bitscope.display
    bitscope.console
    bitscope.chart
  ];
}
