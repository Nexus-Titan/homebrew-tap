class TiwutLauncher < Formula
  desc "Official desktop client for Tiwut project applications"
  homepage "https://tiwut.org"
  url "https://github.com/tiwut/Tiwut-Launcher/archive/refs/tags/V4.2.3.tar.gz"
  version "4.2.3"
  sha256 "d64fa46b2e9c55de62371c563099c903df9f0979202502622100aaf6d6a1c1b7"
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
        Formula["mesa"].opt_prefix
      ]
    end

    args = std_cmake_args + %W[
      -DCMAKE_PREFIX_PATH=#{prefixes.join(";")}
      -DQT_DIR=#{qt_path}/lib/cmake/Qt6
    ]

    mkdir "build" do
      system "cmake", "..", *args
      system "make"
      bin.install "NexusLauncher"
    end
  end
end
