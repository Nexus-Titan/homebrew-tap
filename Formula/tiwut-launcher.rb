class TiwutLauncher < Formula
  desc "Official desktop client for Tiwut project applications"
  homepage "https://tiwut.org"
  url "https://github.com/tiwut/Tiwut-Launcher/archive/refs/tags/V4.2.3.tar.gz"
  version "4.2.3"
  sha256 "d64fa46b2e9c55de62371c563099c903df9f0979202502622100aaf6d6a1c1b7"
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
