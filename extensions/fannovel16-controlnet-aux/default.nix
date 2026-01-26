{ buildExtension
, fetchFromGitHub
, lib
, python3
,
}:

buildExtension {
  name = "fannovel16-controlnet-aux";
  version = "0.0.0";

  src = fetchFromGitHub {
    owner = "Fannovel16";
    repo = "comfyui_controlnet_aux";
    fetchSubmodules = false;
    rev = "5a049bde9cc117dafc327cded156459289097ea1";
    hash = "sha256-LFC2BakhykMXEfdldPCBHnqizjOEgXyzgm3yhN2DFec=";
  };

  propagatedBuildInputs = [
    python3.pkgs.addict
    python3.pkgs.albumentations
    python3.pkgs.einops
    python3.pkgs.filelock
    python3.pkgs.ftfy
    python3.pkgs.fvcore
    python3.pkgs.huggingface-hub
    python3.pkgs.importlib-metadata
    python3.pkgs.matplotlib
    python3.pkgs.mediapipe
    python3.pkgs.numpy
    python3.pkgs.omegaconf
    python3.pkgs.opencv-python
    python3.pkgs.pillow
    python3.pkgs.python-dateutil
    python3.pkgs.pyyaml
    python3.pkgs.scikit-image
    python3.pkgs.scikit-learn
    python3.pkgs.scipy
    python3.pkgs.svglib
    python3.pkgs.torch
    python3.pkgs.torchvision
    python3.pkgs.trimesh
    python3.pkgs.yacs
    python3.pkgs.yapf
  ];

  postPatch = ''
    find . -type f -name "*.py" | while IFS= read -r filename; do
      substituteInPlace "$filename" \
        --replace-quiet \
          'CATEGORY = "ControlNet Preprocessors' \
          'CATEGORY = "controlnet_preprocessors'
    done

    mkdir --parents ckpts
    touch ckpts/.keep
  '';

  passthru = {
    comfyui.stateDirs = [
      "custom_nodes/fannovel16-controlnet-aux/ckpts"
    ];

    check-pkgs.fromImports = false;
  };

  meta = {
    license = lib.licenses.asl20;
  };
}
