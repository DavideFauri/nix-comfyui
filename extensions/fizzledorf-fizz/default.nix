{ buildExtension
, fetchFromGitHub
, lib
, python3
,
}:

buildExtension {
  name = "fizzledorf-fizz";
  version = "0.0.0";

  src = fetchFromGitHub {
    owner = "FizzleDorf";
    repo = "ComfyUI_FizzNodes";
    fetchSubmodules = false;
    rev = "7d6ea60c55ebd1268bd76fa462da052852bff192";
    hash = "sha256-LoF2zCPDh5XK5bYpnnKPj78xkitXqx1861lVqxxGvVQ=";
  };

  propagatedBuildInputs = [
    python3.pkgs.numexpr
    python3.pkgs.numpy
    python3.pkgs.pandas
    python3.pkgs.torch
  ];

  patches = [
    ./0001-disable-js-stub.patch
  ];

  postPatch = ''
    find . -type f -name "*.py" | while IFS= read -r filename; do
      sed --in-place \
        "s/[[:space:]]*📅🅕🅝[[:space:]]*//g" \
        -- "$filename"

      substituteInPlace "$filename" \
        --replace-quiet \
          'CATEGORY = "FizzNodes' \
          'CATEGORY = "fizz_nodes'
    done
  '';

  passthru = {
    check-pkgs.ignoredModuleNames = [
      "^__main__$"
    ];
  };

  meta = {
    license = lib.licenses.mit;
  };
}
