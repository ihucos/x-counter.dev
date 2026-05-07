{ pkgs ? import <nixpkgs> {} }:

let
  yasha = pkgs.python3Packages.buildPythonPackage rec {
    pname = "yasha";
    version = "5.0";
    src = pkgs.python3Packages.fetchPypi {
      inherit pname version;
      sha256 = "sha256-+FFt7XwB5ExHKIZP/mtVFXNJaTj1gv1SHqIf2C2woGA=";
    };
    propagatedBuildInputs = with pkgs.python3Packages; [
      jinja2
      pyyaml
      click
    ];
  };

  pythonEnv = pkgs.python3.withPackages (ps: with ps; [
    pelican
    yasha
    pyyaml
  ]);
in
pkgs.mkShell {
  nativeBuildInputs = [
    pkgs.gnumake
    pythonEnv
  ];
}
