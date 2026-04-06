{ config, pkgs, lib, ... }:

{
  services.ollama = {
    enable = true;
    package = pkgs.ollama-vulkan;
    loadModels = [ "gemma4:26b" ];
  };
}
