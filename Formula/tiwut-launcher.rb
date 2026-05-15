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
      prefixes << Formula["libxkbcommon"].opt_prefix
      prefixes << Formula["libx11"].opt_prefix
      prefixes << Formula["mesa"].opt_prefix
      prefixes << Formula["fontconfig"].opt_prefix
      prefixes << Formula["freetype"].opt_prefix
    end

    if OS.linux?
      ENV.append "LDFLAGS", "-L#{Formula["libxkbcommon"].opt_lib} -L#{Formula["mesa"].opt_lib}"
      ENV.append "CPPFLAGS", "-I#{Formula["libxkbcommon"].opt_include}"
      ENV["PKG_CONFIG_PATH"] = "#{Formula["libxkbcommon"].opt_lib}/pkgconfig"
    end

    args = std_cmake_args + %W[
      -DCMAKE_PREFIX_PATH=#{prefixes.join(";")}
      -DQT_DIR=#{qt_path}/lib/cmake/Qt6
    ]

    system "cmake", "-S", ".", "-B", "build", *args
    system "cmake", "--build", "build"
    
    bin.install "build/NexusLauncher"
  end
end
