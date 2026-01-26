{ buildExtension
, fetchFromGitHub
, lib
,
}:

buildExtension {
  name = "florestefano1975-portrait-master";
  version = "0.0.0";

  src = fetchFromGitHub {
    owner = "florestefano1975";
    repo = "comfyui-portrait-master";
    fetchSubmodules = false;
    rev = "59795c43e610cf163812076430138f7a9bfc8366";
    hash = "sha256-+YANDNvK1sySYCH6LQquyyHtHd8tTSdz7AWE2E4clyg=";
  };

  postPatch = ''
    find . -type f -name "*.py" | while IFS= read -r filename; do
      substituteInPlace "$filename" \
        --replace-quiet \
          'CATEGORY = "AI WizArt/Portrait Master' \
          'CATEGORY = "portrait_master' \
        --replace-quiet "'random 🎲'" "'Random'"
    done
  '';

  meta = {
    license = lib.licenses.gpl3;
  };
}
