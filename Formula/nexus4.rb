class Nexus4 < Formula
  desc "C++ based interpreter for the Nexus language"
  homepage "https://tiwut.org/nexus"
  url "https://github.com/Nexus-Titan/Nexus-the-programming-language/archive/refs/tags/V4.1.2.tar.gz"
  sha256 "2ceb09792c34aeb4261a14d2a1808d8b522e94f0683481ca3895d73bc8f588e4"
  license "MIT"

  def install
    system ENV.cxx, "-o", "nexus", "interpreter.cpp"
    bin.install "nexus" => "nexus4"
  end

  test do
    assert_path_exists bin/"nexus4"
  end
end
