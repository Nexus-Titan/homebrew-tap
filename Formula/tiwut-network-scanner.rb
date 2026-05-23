class TiwutNetworkScanner < Formula
  desc "Advanced Network Scanner"
  homepage "https://github.com/tiwut/Network-Scanner"
  url "https://codeload.github.com/tiwut/Network-Scanner/tar.gz/refs/tags/v2.4.6"
  sha256 "756292e4cee517289ee946dfed9afff8bf2031d41735e5d9b71292f6dded58c9"
  license "MIT"
  version "2.4.6"

  depends_on "cmake" => :build
  depends_on "pkg-config" => :build
  depends_on "qt"

  on_linux do
    depends_on "gcc"
  end

  def install
    args = std_cmake_args + %W[
      -DCMAKE_PREFIX_PATH=#{Formula["qt"].opt_prefix}
    ]
    
    system "cmake", "-S", ".", "-B", "build", *args
    system "cmake", "--build", "build"
    
    if File.exist?("build/Network-Scanner")
      bin.install "build/Network-Scanner"
    elsif File.exist?("build/OmniScan")
      bin.install "build/OmniScan" => "Network-Scanner"
    else
      executable = Dir["build/*"].find { |f| File.file?(f) && File.executable?(f) }
      bin.install executable => "Network-Scanner" if executable
    end
  end

  test do
    assert_predicate bin/"Network-Scanner", :exist?
    assert_predicate bin/"Network-Scanner", :executable?
  end
end
