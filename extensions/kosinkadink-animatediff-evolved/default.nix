{
  buildExtension,
  fetchFromGitHub,
  ffmpeg,
  lib,
  python3,
}:

buildExtension {
  name = "kosinkadink-animatediff-evolved";
  version = "0.0.0";

  src = fetchFromGitHub {
    owner = "Kosinkadink";
    repo = "ComfyUI-AnimateDiff-Evolved";
    fetchSubmodules = false;
    rev = "4f1344e25387d21cdded8f48f4bc59bd86bea9e8";
    hash = "sha256-mDXLvL87PCgJdk4a4oFnBj2Z2QBSllsghr0/ncZTH2k=";
  };

  propagatedBuildInputs = [
    python3.pkgs.einops
    python3.pkgs.numpy
    python3.pkgs.pillow
    python3.pkgs.torch
    python3.pkgs.torchvision
  ];

  patches = [
    ./0001-subst-executables.patch
  ];

  postPatch = ''
    substituteInPlace animatediff/nodes_deprecated.py \
      --subst-var-by ffmpeg ${lib.getExe ffmpeg}

    find . -type f \( -name "*.py" -o -name "*.js" \) | xargs sed --in-place \
      "s/[[:space:]]*\(🎭🅐🅓①\|🎭🅐🅓\|🎭\|🧪\|🚫\|①\|②\)[[:space:]]*//g" --

    find . -type f -name "*.py" | while IFS= read -r filename; do
      substituteInPlace "$filename" \
        --replace-quiet \
          'CATEGORY = "Animate Diff' \
          'CATEGORY = "animate_diff' \
        --replace-quiet \
          'CATEGORY = ""' \
          'CATEGORY = "animate_diff/deprecated"' \
        --replace-quiet "◆" " - "
    done
  '';

  passthru = {
    comfyui.stateDirs = [
      "custom_nodes/kosinkadink-animatediff-evolved/models"
      "custom_nodes/kosinkadink-animatediff-evolved/motion_lora"
      "custom_nodes/kosinkadink-animatediff-evolved/video_formats"
    ];
  };

  meta = {
    license = lib.licenses.asl20;
  };
}
