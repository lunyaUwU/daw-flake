
{ lib
, libGLU
, libGL
, librsvg
, file
, stdenv
, alsa-lib
, aubio
, boost
, cairomm
, cppunit
, curl
, dbus
, doxygen
, ffmpeg
, fftw
, fftwSinglePrec
, flac
, fluidsynth
, glibc
, glibmm
, graphviz
, gtkmm2
, harvid
, hidapi
, itstool
, kissfft
, libarchive
, libjack2
, liblo
, libltc
, libogg
, libpulseaudio
, librdf_raptor
, librdf_rasqal
, libsamplerate
, libsigcxx
, libsndfile
, libusb1
, libuv
, libwebsockets
, libxml2
, libxslt
, lilv
, lrdf
, lv2
, makeWrapper
, pango
, perl
, pkg-config
, python3
, qm-dsp
, readline
, rubberband
, serd
, sord
, soundtouch
, sratom
, suil
, taglib
, vamp-plugin-sdk
, wafHook
, xjadeo
, autoPatchelfHook
, wrapGAppsHook
, requireFile
, gcc-unwrapped
, xorg
}:
stdenv.mkDerivation rec {
  name = "mixbus";
  version = "10.2.3";
  major = lib.versions.major version;
  src = requireFile {
    name= "Mixbus_x86_64-${version}.tar";
    sha256= "cc1fd936d6aa8bdf064ab11fc0a5a519acbbef6c1fe98919197e3f3c85b782e1";
    url = "google.com";
  };

  nativeBuildInputs = [ autoPatchelfHook];
  buildInputs = with xorg;[
    alsa-lib
    aubio
    boost
    cairomm
    cppunit
    curl
    dbus
    ffmpeg
    fftw
    fftwSinglePrec
    flac
    fluidsynth
    glibmm
    gtkmm2
    hidapi
    itstool
    kissfft
    libarchive
    libjack2
    liblo
    libltc
    libogg
    libpulseaudio
    librdf_raptor
    librdf_rasqal
    libsamplerate
    libsigcxx
    libsndfile
    libusb1
    libuv
    libwebsockets
    libxml2
    libxslt
    lilv
    lrdf
    lv2
    pango
    perl
    python3
    qm-dsp
    readline
    rubberband
    serd
    sord
    soundtouch
    sratom
    suil
    taglib
    vamp-plugin-sdk

    file
    stdenv.cc.cc.lib  # libstdc++.so.6
    gcc-unwrapped # Provides libstdc++ v6
    libGLU
    libX11
    libXext
    libXrender
    libXrandr
    libxcb
    libXinerama
    libGL
    librsvg
    libGLU
  ];
  unpackCmd = ''
    mkdir -p root
    tar -xf $curSrc -C root
    ls
  '';
  
  installPhase = ''
    runHook preInstall
    ls
    mkdir -p $out/bin
    mkdir -p $out/lib

    cp -r Mixbus_x86_64-$version $out/libexec
    ln -s $out/libexec/lib/* $out/lib/
    ln -s $out/libexec/bin/mixbus${major} $out/bin/mixbus
    addAutoPatchelfSearchPath $out/lib/
    runHook postInstall
  '';
    #preFixup = let
    # we prepare our library path in the let clause to avoid it become part of the input of mkDerivation

  # postFixup = ''
  #   # patchelf fails to set rpath on BitwigStudioEngine, so we use
  #   # the LD_LIBRARY_PATH way
  #
  #   find $out -type f -executable \
  #     -exec sh -c "[[ \"\$(head -c 4 -- \"\$\{1\}\")\" == \$'\\x7FELF' ]]" -- \{\} \;
  #   while IFS= read -r f ; do
  #     patchelf --set-interpreter "${stdenv.cc.bintools.dynamicLinker}" $f
  #     # make xdg-open overrideable at runtime
  #     wrapProgram $f \
  #       --prefix PATH : "${lib.makeBinPath [ ffmpeg ]}" \
  #       --suffix PATH : "${lib.makeBinPath [ xdg-utils ]}" \
  #       --suffix LD_LIBRARY_PATH : "${lib.strings.makeLibraryPath buildInputs}"
  #   done
  # '';

  }

