class TiwutNetworkScanner < Formula
  desc "Advanced Network Scanner"
  homepage "https://github.com/tiwut/Network-Scanner"
  url "https://codeload.github.com/tiwut/Network-Scanner/tar.gz/refs/tags/v2.4.6"
  sha256 "756292e4cee517289ee946dfed9afff8bf2031d41735e5d9b71292f6dded58c9"
  license "MIT"
  version "2.4.6"

  env :std

  depends_on "cmake" => :build
  depends_on "pkg-config" => :build
  depends_on "qt"

  on_linux do
    depends_on "gcc"
  end

  def install
    system "cmake", "-S", ".", "-B", "build", *std_cmake_args
    system "cmake", "--build", "build"
    
    bin.install "build/Network-Scanner"
  end

  test do
    assert_predicate bin/"Network-Scanner", :exist?
    assert_predicate bin/"Network-Scanner", :executable?
  end
end
