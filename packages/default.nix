{ callPackage, comfyui-frontend }:

{
  check-pkgs = callPackage ./check-pkgs { };

  comfyui = callPackage ./comfyui {
    bwrapArgs = [ ];
    commandLineArgs = [ ];
    extensions = [ ];
    frontend = comfyui-frontend;
    prepopulatedStateFiles = [ ];
    stateDirs = [ ];
  };

  comfyui-frontend = callPackage ./comfyui-frontend { };

  comfyui-unwrapped = callPackage ./comfyui-unwrapped { };

  krita-ai-diffusion = callPackage ./krita-ai-diffusion { };
}
