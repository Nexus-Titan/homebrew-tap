class TiwutMacAppCreator < Formula
  desc "Automated tool to create macOS .app bundles from CMake C++ projects"
  homepage "https://github.com/tiwut/macOS-App-Creator"
  url "https://github.com/tiwut/macOS-App-Creator/archive/refs/tags/v1.1.1.tar.gz"
  sha256 "0000000000000000000000000000000000000000000000000000000000000000"
  license "MIT"

  if OS.linux?
    odie "Sorry! tiwut-mac-app-creator is a macOS-exclusive tool for building macOS .app bundles. It cannot run on Linux."
  end

  depends_on :macos
  depends_on "cmake"
  depends_on "dylibbundler"

  def install
    system ENV.cxx, "-std=c++17", "-O3", "mac-app-creator.cpp", "-o", "mac-app-creator"
    bin.install "mac-app-creator"
  end

  test do
    assert_predicate bin/"mac-app-creator", :exist?
    assert_match "Error: You must specify a path using -path", shell_output("#{bin}/mac-app-creator 2>&1", 1)
  end
end
