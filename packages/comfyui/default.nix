{ bubblewrap
, bwrapArgs
, comfyui-unwrapped
, commandLineArgs
, extensions
, frontend
, lib
, makeBinaryWrapper
, platform
, prepopulatedStateFiles
, python3
, stateDirs
, stdenv
, writeText
,
}:

let
  inherit (python3) sitePackages;

  propagatedBuildInputs = builtins.foldl'
    (
      acc: extension: acc ++ (extension.propagatedBuildInputs or [ ])
    )
    comfyui-unwrapped.propagatedBuildInputs
    extensions;

  interpreter = python3.withPackages (_: propagatedBuildInputs);

  passthrus = map (p: (p.passthru or { }).comfyui or { }) ([ comfyui-unwrapped ] ++ extensions);

  finalStateDirs = lib.flatten (stateDirs ++ (map (p: p.stateDirs or [ ]) passthrus));

  finalPrepopulatedStateFiles = lib.flatten (
    prepopulatedStateFiles ++ (map (p: p.prepopulatedStateFiles or [ ]) passthrus)
  );

  specJson = writeText "spec.json" (
    builtins.toJSON {
      bwrap = lib.getExe bubblewrap;
      bwrap_args = bwrapArgs;
      comfyui = "${comfyui-unwrapped}/${sitePackages}";
      comfyui_args = commandLineArgs;
      extensions = builtins.listToAttrs (
        map
          (ext: {
            name = ext.passthru.originalName;
            value = "${ext}/${sitePackages}";
          })
          extensions
      );
      frontend = "${frontend}/share/comfyui/web";
      interpreter = lib.getExe interpreter;
      prepopulated_state_files = finalPrepopulatedStateFiles;
      state_dirs = finalStateDirs;
    }
  );
in

stdenv.mkDerivation {
  name = "comfyui";

  nativeBuildInputs = [
    makeBinaryWrapper
  ];

  dontUnpack = true;

  makeWrapperArgs = lib.flatten [
    (lib.getExe python3)
    "${placeholder "out"}/bin/comfyui"

    "--inherit-argv0"

    [
      "--add-flags"
      "${./wrapper.py}"
    ]
    [
      "--add-flags"
      "${specJson}"
    ]

    # "RuntimeError: Found no NVIDIA driver on your system..."
    [
      "--prefix"
      "LD_LIBRARY_PATH"
      ":"
      "/run/opengl-driver/lib"
    ]

    # "UserWarning: A new version of Albumentations is available..."
    [
      "--set-default"
      "NO_ALBUMENTATIONS_UPDATE"
      "1"
    ]

    (lib.optionals (platform == "cuda") [
      # Some dependencies try to dlopen() libnvrtc.so.12 at runtime,
      # namely torch and cupy-cuda12x.
      "--prefix"
      "LD_LIBRARY_PATH"
      ":"
      "${python3.pkgs.nvidia-cuda-nvrtc-cu12}/${sitePackages}/nvidia/cuda_nvrtc/lib"
    ])
  ];

  preInstall = ''
    mkdir --parents $out/bin
    makeWrapper ''${makeWrapperArgs[@]}
  '';
}
