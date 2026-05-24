class TiwutBrewFormulaGenerator < Formula
  desc "C++ application built with CMake"
  homepage "https://github.com/tiwut/Brew-Formula-Generator"
  license "MIT"
  version "1.1.1"

  if OS.mac?
    url "https://github.com/tiwut/Brew-Formula-Generator/archive/refs/tags/v1.1.1.tar.gz"
    sha256 "c3f6d07957ce8d63c54ce6c2826cefc3ef53329e732dab0d6aa40c3c49d1e430"

    depends_on "cmake" => :build
    depends_on "qt"
  elsif OS.linux?
    url "https://github.com/tiwut/Brew-Formula-Generator/releases/download/v1.1.1/BrewFormulaGenerator.AppImage"
    sha256 "92448faa6543054ae4fc735c918290096c799c27b0e4c0fb73e562c5ec6a3e3b"
  end

  def install
    if OS.mac?
      system "cmake", "-S", ".", "-B", "build", *std_cmake_args
      system "cmake", "--build", "build"
      bin.install "build/BrewFormulaGenerator"
    elsif OS.linux?
      appimage = Dir["*.AppImage"].first
      bin.install appimage => "BrewFormulaGenerator"
    end
  end

  test do
    assert_predicate bin/"BrewFormulaGenerator", :exist?
    assert_predicate bin/"BrewFormulaGenerator", :executable?
  end
end
