class NexusTitan < Formula
  desc "C++ based interpreter for the Nexus language"
  homepage "https://tiwut.org"
  url "https://github.com/Nexus-Titan/Nexus-the-programming-language/archive/refs/tags/V4.1.1.tar.gz"
  sha256 "2b56b1bff0f32d573d42054268e1b74710b46eef877321d236f264bdfe115ee6"
  license "MIT"
  version "4.1.1"
  
  def install
    system "g++", "-o", "nexus", "interpreter.cpp"
    
    bin.install "nexus"
  end

  test do
    assert_predicate bin/"nexus", :exist?
  end
end
