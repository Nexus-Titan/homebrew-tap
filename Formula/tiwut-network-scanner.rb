class TiwutNetworkScanner < Formula
  desc "Advanced Network Scanner"
  homepage "https://github.com/tiwut/Network-Scanner"
  version "2.4.6"
  license "MIT"

  if OS.mac?
    url "https://codeload.github.com/tiwut/Network-Scanner/tar.gz/refs/tags/v2.4.6"
    sha256 "756292e4cee517289ee946dfed9afff8bf2031d41735e5d9b71292f6dded58c9"

    depends_on "cmake" => :build
    depends_on "qt"
  elsif OS.linux?
    url "https://github.com/tiwut/Network-Scanner/releases/download/v2.4.6/Network_Scanner-x86_64.AppImage"
    sha256 "756292e4cee517289ee946dfed9afff8bf2031d41735e5d9b71292f6dded58c9"
  end

  def install
    if OS.mac?
      system "cmake", "-S", ".", "-B", "build", *std_cmake_args
      system "cmake", "--build", "build"
      bin.install "build/Network-Scanner"
    elsif OS.linux?
      appimage = Dir["*.AppImage"].first
      bin.install appimage => "Network-Scanner"
    end
  end

  test do
    assert_predicate bin/"Network-Scanner", :exist?
    assert_predicate bin/"Network-Scanner", :executable?
  end
end
