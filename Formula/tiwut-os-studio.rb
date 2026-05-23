class TiwutOsStudio < Formula
  desc "OS-Studio: Integrated Development Environment for OS Development"
  homepage "https://github.com/tiwut/OS-Studio"
  url "https://github.com/tiwut/OS-Studio/archive/refs/tags/version1.0.tar.gz"
  sha256 "3eeea6c6d2af4b41035ffcefdbec5e6c7e36126e04fce1db6fe432b13e8f837f" 
  license "GPL-3.0"

  depends_on "cmake" => :build
  depends_on "node"
  depends_on "qt"

  def install
    system "npm", "install"
    system "npm", "run", "build"
    mkdir "native_launcher/build" do
      system "cmake", "..", *std_cmake_args
      system "make"
    end

    bin.install "native_launcher/build/OS_Studio_Launcher" => "tiwut-os-studio"
  end

  test do
    system "#{bin}/tiwut-os-studio", "--version"
  end
end
