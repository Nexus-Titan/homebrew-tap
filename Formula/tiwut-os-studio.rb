class TiwutOsStudio < Formula
  desc "OS-Studio: Integrated Development Environment for OS Development"
  homepage "https://github.com/tiwut/OS-Studio"
  url "https://github.com/tiwut/OS-Studio/archive/refs/tags/version1.0.tar.gz"
  sha256 "c6fa75c841cbffac851678a472f2a5bd612fff8308ef39236190e1f8dbb0e567" 
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
