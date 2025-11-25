{
  buildExtension,
  fetchFromGitHub,
  lib,
  python3,
}:

buildExtension {
  name = "ssitu-ultimate-sd-upscale";
  version = "0.0.0";

  src = fetchFromGitHub {
    owner = "ssitu";
    repo = "ComfyUI_UltimateSDUpscale";
    fetchSubmodules = true;
    rev = "e617ff20e7ef5baf6526c5ff4eb46a35d24ecbba";
    hash = "sha256-J1Vj9LD5N882KMY0RAIBNOv149D7Cl/MOuajUEeL05s=";
  };

  propagatedBuildInputs = [
    python3.pkgs.numpy
    python3.pkgs.pillow
    python3.pkgs.torch
    python3.pkgs.torchvision
  ];

  passthru = {
    check-pkgs.ignoredModuleNames = [
      "^gradio$"
      "^modules(\\..+)?$"
      "^repositories$"
      "^usdu_patch$"
    ];
  };

  meta = {
    license = lib.licenses.gpl3;
  };
}
