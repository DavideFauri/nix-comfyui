{
  buildExtension,
  fetchFromGitHub,
  lib,
  python3,
}:

buildExtension {
  name = "kijai-ic-light";
  version = "0.0.0";

  src = fetchFromGitHub {
    owner = "kijai";
    repo = "ComfyUI-IC-Light";
    fetchSubmodules = false;
    rev = "7def1cf111bef9fa368190624370312f03145c28";
    hash = "sha256-Qtlmee9o8o64ZdsqRJ3d6ZvxulCQ1hn+Mcn+l95mbCU=";
  };

  propagatedBuildInputs = [
    python3.pkgs.numpy
    python3.pkgs.opencv-python
    python3.pkgs.torch
    python3.pkgs.torchvision
  ];

  postPatch = ''
    find . -type f -name "*.py" | while IFS= read -r filename; do
      substituteInPlace "$filename" \
        --replace-quiet \
          'CATEGORY = "IC-Light' \
          'CATEGORY = "ic_light'
    done
  '';

  passthru = {
    check-pkgs.ignoredModuleNames = [
      "^model_management$"
    ];
  };

  meta = {
    license = lib.licenses.asl20;
  };
}
