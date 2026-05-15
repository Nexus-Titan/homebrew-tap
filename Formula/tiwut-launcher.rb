class TiwutLauncher < Formula
  desc "Official desktop client for Tiwut project applications"
  homepage "https://tiwut.org"
  license "MIT"
  version "4.2.4"

  if OS.mac?
    url "https://github.com/tiwut/Tiwut-Launcher/archive/refs/tags/V4.2.4.tar.gz"
    sha256 "2b56b1bff0f32d573d42054268e1b74710b46eef877321d236f264bdfe115ee6"
    
    depends_on "cmake" => :build
    depends_on "qt"
  elsif OS.linux?
    url "https://github.com/tiwut/Tiwut-Launcher/releases/download/V4.2.4/Tiwut-Launcher-x86_64.AppImage"
    sha256 "2b56b1bff0f32d573d42054268e1b74710b46eef877321d236f264bdfe115ee6"
  end

  def install
    if OS.mac?
      qt_path = Formula["qt"].opt_prefix
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
    elsif OS.linux?
      bin.install "NexusLauncher-linux-x86_64" => "NexusLauncher"
    end
  end
end
