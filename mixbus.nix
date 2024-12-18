
{ stdenv
, fetchurl
, alsa-lib
, atk
, cairo
, dpkg
, ffmpeg
, freetype
, gdk-pixbuf
, glib
, gtk3
, harfbuzz
, lib
, libglvnd
, libjack2
, libjpeg
, libxkbcommon
, makeWrapper
, pango
, pipewire
, pulseaudio
, wrapGAppsHook
, xdg-utils
, xorg
, zlib
, webkitgtk
, curl
, fftwFloat
, jack2
, vulkan-loader
, fetchzip
, requireFile
}:
stdenv.mkDerivation rec {
  name = "mixbus";
  version = "10.2.3";
  src = requireFile {
    name= "Mixbus_x86_64-${version}.tar";
    sha256= "cc1fd936d6aa8bdf064ab11fc0a5a519acbbef6c1fe98919197e3f3c85b782e1";
  };

  nativeBuildInputs = [ dpkg makeWrapper wrapGAppsHook ];

  unpackCmd = ''
    mkdir -p root
    tar -xf $curSrc root
  '';

}

