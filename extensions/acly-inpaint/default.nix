{ buildExtension
, fetchFromGitHub
, lib
, python3
,
}:

buildExtension {
  name = "acly-inpaint";
  version = "0.0.0";

  src = fetchFromGitHub {
    owner = "Acly";
    repo = "comfyui-inpaint-nodes";
    fetchSubmodules = false;
    rev = "20092c37b9dfc481ca44e8577a9d4a9d426c0e56";
    hash = "sha256-yI8dbm10MFGBjerVdIAHSBqRPtvcVJ5t/BsSmVkWlXY=";
  };

  propagatedBuildInputs = [
    python3.pkgs.kornia
    python3.pkgs.numpy
    python3.pkgs.opencv-python
    python3.pkgs.spandrel
    python3.pkgs.torch
    python3.pkgs.tqdm
  ];

  meta = {
    license = lib.licenses.gpl3;
  };
}
