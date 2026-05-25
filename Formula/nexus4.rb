class Nexus4 < Formula
  desc "C++ based interpreter for the Nexus language"
  homepage "https://tiwut.org/nexus"
  url "https://github.com/Nexus-Titan/Nexus-the-programming-language/archive/refs/tags/v4.1.3.tar.gz"
  sha256 "3de48d7930141c986826f9397cd34a2cb8226acabff481e5015a3a20a85253ef"
  license "MIT"

  def install
    system ENV.cxx, "-o", "nexus", "interpreter.cpp"
    bin.install "nexus" => "nexus4"
  end

  test do
    assert_path_exists bin/"nexus4"
  end
end
