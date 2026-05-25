class Nexus4 < Formula
  desc "C++ based interpreter for the Nexus language"
  homepage "https://tiwut.org/nexus"
  url "https://github.com/Nexus-Titan/Nexus-the-programming-language/archive/refs/tags/v4.5.0.tar.gz"
  sha256 "3de48d7930141c986826f9397cd34a2cb8226acabff481e5015a3a20a85253ef"
  license "MIT"
  depends_on "cmake" => :build
  depends_on "libx11"
  depends_on "openssl@3"

  def install
    system "cmake", "-S", ".", "-B", "build", *std_cmake_args
    system "cmake", "--build", "build"
    bin.install "nexus" => "nexus4"
  end

  test do
    assert_predicate bin/"nexus4", :executable?
  end
end
