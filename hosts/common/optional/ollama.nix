{ config, lib, pkgs, ... }:
{
  services.ollama = {
    enable = true;
    acceleration = "rocm";
    environmentVariables = {
      HOME = "/home/ollama";
      OLLAMA_MODELS = "/home/ollama/models";
      OLLAMA_HOST = "0.0.0.0:11434";
      OLLAMA_ORIGINS = "https://localhost:8080,http://192.186.1.10:*";
    };
  };
  environment.systemPackages = with pkgs; [
    oterm
  ];
}

