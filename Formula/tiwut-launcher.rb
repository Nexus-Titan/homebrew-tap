class TiwutLauncher < Formula
  desc "Official desktop client for Tiwut project applications"
  homepage "https://tiwut.org"
  url "https://github.com/tiwut/Tiwut-Launcher/archive/refs/tags/V4.2.3.tar.gz"
  version "4.2.3"
  sha256 "52da2c395eb56a3d3c4e3dd09ad900bd03f3ce94853af5e75eb1272a3e64f65f"
  license "MIT"

  depends_on "cmake" => :build
  depends_on "qt"

  def install
    system "cmake", "-S", ".", "-B", "build", *std_cmake_args
    system "cmake", "--build", "build"
    bin.install "build/NexusLauncher"
  end

  test do
    system "#{bin}/NexusLauncher", "--version"
  end
end
