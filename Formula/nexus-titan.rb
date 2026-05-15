class Nexus < Formula
  desc "C++ based interpreter for the Nexus language"
  homepage "https://tiwut.org"
  url "https://github.com/Nexus-Titan/Nexus-the-programming-language/archive/refs/tags/V4.1.1.tar.gz"
  sha256 "625476542754274257245gfhghwezt453342"
  license "MIT"
  version "4.1.1"

  def install
    system "g++", "-o", "nexus", "interpreter.cpp"
    bin.install "nexus"
  end

  test do
    assert_match "Nexus", shell_output("#{bin}/nexus --version", 2)
  end
end
