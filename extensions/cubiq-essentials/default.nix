{ buildExtension
, fetchFromGitHub
, lib
, python3
,
}:

buildExtension {
  name = "cubiq-essentials";
  version = "0.0.0";

  src = fetchFromGitHub {
    owner = "cubiq";
    repo = "ComfyUI_essentials";
    fetchSubmodules = false;
    rev = "33ff89fd354d8ec3ab6affb605a79a931b445d99";
    hash = "sha256-7BaIhvHmBdUUbJaqdWAZO8lxZHWQfZJmM95wGa9xLYg=";
  };

  propagatedBuildInputs = [
    python3.pkgs.colour-science
    python3.pkgs.kornia
    python3.pkgs.numba
    python3.pkgs.numpy
    python3.pkgs.opencv-python
    python3.pkgs.pillow
    python3.pkgs.pixeloe
    python3.pkgs.rembg
    python3.pkgs.scikit-image
    python3.pkgs.scipy
    python3.pkgs.torch
    python3.pkgs.torchvision
    python3.pkgs.transformers
    python3.pkgs.transparent-background
  ];

  postPatch = ''
    find . -type f -name "*.py" | xargs sed --in-place \
      "s/[[:space:]]*🔧[[:space:]]*//g" --
  '';

  passthru = {
    comfyui.stateDirs = [
      "custom_nodes/cubiq-essentials/fonts"
      "custom_nodes/cubiq-essentials/luts"
    ];

    comfyui.prepopulatedStateFiles = [
      "custom_nodes/cubiq-essentials/fonts/ShareTechMono-Regular.ttf"
    ];
  };

  meta = {
    license = lib.licenses.mit;
  };
}
