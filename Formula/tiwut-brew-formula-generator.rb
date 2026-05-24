class TiwutBrewFormulaGenerator < Formula
  desc "C++ application built with CMake"
  homepage "https://github.com/tiwut/Brew-Formula-Generator"
  license "MIT"
  version "1.1.1"
  url "https://github.com/tiwut/Brew-Formula-Generator/archive/refs/tags/v1.1.1.tar.gz"
  sha256 "c3f6d07957ce8d63c54ce6c2826cefc3ef53329e732dab0d6aa40c3c49d1e430"

  depends_on "cmake" => :build
  depends_on "qt"

  def install
    system "cmake", "-S", ".", "-B", "build", *std_cmake_args
    system "cmake", "--build", "build"
    system "cmake", "--install", "build"
  end

  test do
    assert_predicate bin/"BrewFormulaGenerator", :exist?
    assert_predicate bin/"BrewFormulaGenerator", :executable?
  end

end
