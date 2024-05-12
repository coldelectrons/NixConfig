{ config, lib, pkgs, ... }:
{
  services.ollama = {
    enable = true;
    acceleration = "cuda";
    environmentVariables = {
      HOME = "/home/ollama";
      OLLAMA_MODELS = "/home/ollama/models";
      OLLAMA_HOST = "0.0.0.0:11434";
      OLLAMA_ORIGINS = "https://localhost:8080,http://192.186.1.10:*";
    };
  };
  # services.llama-cpp = {
  #   enable = true;
  #   host = "0.0.0.0";
  #   port = 8080;
  #   openFirewall = true;
  #   # model = "/model-path/model-name/model.gguf";
  #   extraFlags = [
  #     "-c" "4096"
  #   ];
  # };
  environment.systemPackages = with pkgs; [
    oterm
    aichat
    # colmapWithCuda # doesn't compile
    # python312Packages.opensfm # error about distutils:
  ];
}

