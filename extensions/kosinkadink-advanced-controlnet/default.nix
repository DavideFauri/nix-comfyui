{
  buildExtension,
  fetchFromGitHub,
  lib,
  python3,
}:

buildExtension {
  name = "kosinkadink-advanced-controlnet";
  version = "0.0.0";

  src = fetchFromGitHub {
    owner = "Kosinkadink";
    repo = "ComfyUI-Advanced-ControlNet";
    fetchSubmodules = false;
    rev = "9632af9dc8f9abe28431c0027411d7a6d4f6cd3e";
    hash = "sha256-eNoKnAW/R0S1GfvuF64XnjR+YxXw7zgYwyj1GFeby10=";
  };

  propagatedBuildInputs = [
    python3.pkgs.einops
    python3.pkgs.numpy
    python3.pkgs.pillow
    python3.pkgs.torch
  ];

  postPatch = ''
    find . -type f -name "*.py" | while IFS= read -r filename; do
      sed --in-place \
        "s/[[:space:]]*\(🛂🅐🅒🅝\|🛂\|🧪\|🚫\)[[:space:]]*//g" \
        -- "$filename"

      substituteInPlace "$filename" \
        --replace-quiet \
          'CATEGORY = "Adv-ControlNet' \
          'CATEGORY = "adv_controlnet' \
        --replace-quiet \
          'CATEGORY = ""' \
          'CATEGORY = "adv_controlnet/deprecated"'
    done
  '';

  meta = {
    license = lib.licenses.gpl3;
  };
}
