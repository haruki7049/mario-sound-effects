{
  pkgs ? import <nixpkgs> { },
}:

pkgs.mkShell {
  nativeBuildInputs = [
    pkgs.zig_0_15 # Zig compiler
    pkgs.zls_0_15 # Zig LSP
    pkgs.pkg-config # pkg-config
  ];

  buildInputs = [
    pkgs.alsa-lib
    pkgs.libpulseaudio
    pkgs.pipewire
  ];
}
