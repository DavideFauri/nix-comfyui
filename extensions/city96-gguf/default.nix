{
  buildExtension,
  fetchFromGitHub,
  lib,
  python3,
}:

buildExtension {
  name = "city96-gguf";
  version = "0.0.0";

  src = fetchFromGitHub {
    owner = "city96";
    repo = "ComfyUI-GGUF";
    fetchSubmodules = false;
    rev = "23b9817081bc56723a4be806e689e7d18e215a80";
    hash = "sha256-WN+AsgjBuaAMQxQSuUQEgONKxE2Cb0PhIT/bcqwK780=";
  };

  propagatedBuildInputs = [
    python3.pkgs.gguf
    python3.pkgs.numpy
    python3.pkgs.safetensors
    python3.pkgs.torch
    python3.pkgs.tqdm
  ];

  meta = {
    license = lib.licenses.asl20;
  };
}
