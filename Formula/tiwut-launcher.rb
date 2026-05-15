class TiwutLauncher < Formula
  desc "Official desktop client for Tiwut project applications"
  homepage "https://tiwut.org"
  url "https://github.com/tiwut/Tiwut-Launcher/archive/refs/tags/V4.2.4.tar.gz"
  version "4.2.4"
  sha256 "2b56b1bff0f32d573d42054268e1b74710b46eef877321d236f264bdfe115ee6"
  license "MIT"

  depends_on "cmake" => :build
  depends_on "qt"

  on_linux do
    depends_on "libxkbcommon"
    depends_on "libx11"
    depends_on "libxext"
    depends_on "mesa"
    depends_on "fontconfig"
    depends_on "freetype"
  end

  def install
    qt_path = Formula["qt"].opt_prefix
    
    prefixes = [qt_path]
    if OS.linux?
      prefixes += [
        Formula["libxkbcommon"].opt_prefix,
        Formula["libx11"].opt_prefix,
        Formula["mesa"].opt_prefix,
        Formula["fontconfig"].opt_prefix,
        Formula["freetype"].opt_prefix
      ]
    end

    args = std_cmake_args + %W[
      -DCMAKE_PREFIX_PATH=#{prefixes.join(";")}
      -DQt6_DIR=#{qt_path}/lib/cmake/Qt6
      -DQt6Core_DIR=#{qt_path}/lib/cmake/Qt6Core
    ]

    mkdir "build" do
      system "cmake", "..", *args
      system "make"
      bin.install "NexusLauncher"
    end
  end
end
