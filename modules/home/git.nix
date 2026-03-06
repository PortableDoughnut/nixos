{
  config,
  pkgs,
  inputs,
  lib,
  ...
}:

{
   home.packages = with pkgs; [
       github-cli 
   ];
}
