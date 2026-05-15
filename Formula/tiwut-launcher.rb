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
    
    if OS.linux?
      ENV.append "LDFLAGS", "-L#{Formula["libxkbcommon"].opt_lib} -L#{Formula["mesa"].opt_lib}"
      ENV.append "CPPFLAGS", "-I#{Formula["libxkbcommon"].opt_include} -I#{Formula["mesa"].opt_include}"
      
      ENV.append_path "PKG_CONFIG_PATH", "#{Formula["libxkbcommon"].opt_lib}/pkgconfig"
      ENV.append_path "PKG_CONFIG_PATH", "#{Formula["mesa"].opt_lib}/pkgconfig"
      ENV.append_path "PKG_CONFIG_PATH", "#{Formula["qt"].opt_lib}/pkgconfig"
    end

    args = std_cmake_args + %W[
      -DQt6Core_DIR=#{qt_path}/lib/cmake/Qt6Core
      -DQt6_DIR=#{qt_path}/lib/cmake/Qt6
      -DCMAKE_PREFIX_PATH=#{qt_path}
    ]

    mkdir "build" do
      system "cmake", "..", *args
      system "make"
      bin.install "NexusLauncher"
    end
  end
end
