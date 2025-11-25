{
  buildExtension,
  fetchFromGitHub,
  lib,
  python3,
}:

buildExtension {
  name = "huchenlei-layerdiffuse";
  version = "0.0.0";

  src = fetchFromGitHub {
    owner = "huchenlei";
    repo = "ComfyUI-layerdiffuse";
    fetchSubmodules = false;
    rev = "6e4aeb2da78ba48c519367608a61bf47ea6249b4";
    hash = "sha256-RTYaPmN9L7MowGIBn2lzv4nEwNJCM3f4BWFZG+ks0Go=";
  };

  propagatedBuildInputs = [
    python3.pkgs.diffusers
    python3.pkgs.einops
    python3.pkgs.numpy
    python3.pkgs.opencv-python
    python3.pkgs.packaging
    python3.pkgs.torch
    python3.pkgs.tqdm
  ];

  passthru = {
    check-pkgs.ignoredModuleNames = [
      "^diffusers.models.unet_2d_blocks$"
    ];
  };

  meta = {
    license = lib.licenses.asl20;
  };
}
