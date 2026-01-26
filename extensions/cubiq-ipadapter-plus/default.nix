{ buildExtension
, fetchFromGitHub
, lib
, python3
,
}:

buildExtension {
  name = "cubiq-ipadapter-plus";
  version = "0.0.0";

  src = fetchFromGitHub {
    owner = "cubiq";
    repo = "ComfyUI_IPAdapter_plus";
    fetchSubmodules = false;
    rev = "b188a6cb39b512a9c6da7235b880af42c78ccd0d";
    hash = "sha256-PeJ+V0I+soHXwZhrXpJ2lQnB0GloKQImUQt28OLVIm8=";
  };

  propagatedBuildInputs = [
    python3.pkgs.einops
    python3.pkgs.insightface
    python3.pkgs.pillow
    python3.pkgs.torch
    python3.pkgs.torchvision
  ];

  meta = {
    license = lib.licenses.gpl3;
  };
}
