{ buildExtension
, fetchFromGitHub
, lib
, python3
,
}:

buildExtension {
  name = "extraltodeus-skimmed-cfg";
  version = "0.0.0";

  src = fetchFromGitHub {
    owner = "Extraltodeus";
    repo = "Skimmed_CFG";
    fetchSubmodules = false;
    rev = "2712803a8b721665d43d5aeb4430e5ac0e931091";
    hash = "sha256-7Z8/9OOJHjHUXP1nbXhHzjFdTsLthq+oFbYRRj525RU=";
  };

  propagatedBuildInputs = [
    python3.pkgs.torch
  ];

  meta = {
    license = lib.licenses.unfree; # not specified
  };
}
