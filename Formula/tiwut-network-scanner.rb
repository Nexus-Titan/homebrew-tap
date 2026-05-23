class TiwutNetworkScanner < Formula
  desc "Advanced Tactical Network Scanner"
  homepage "https://github.com/tiwut/Network-Scanner"
  url "https://codeload.github.com/tiwut/Network-Scanner/tar.gz/refs/tags/v2.4.6"
  sha256 "756292e4cee517289ee946dfed9afff8bf2031d41735e5d9b71292f6dded58c9"
  license "MIT"
  version "2.4.6"

  depends_on "cmake" => :build
  depends_on "qt"

  def install
    ENV["CMAKE_PREFIX_PATH"] = Formula["qt"].opt_lib/"cmake"
    
    system "cmake", "-S", ".", "-B", "build", *std_cmake_args
    system "cmake", "--build", "build"
    
    if File.exist?("build/OmniScan")
      bin.install "build/OmniScan" => "Network-Scanner"
    elsif File.exist?("build/Network-Scanner")
      bin.install "build/Network-Scanner"
    else
      bin.install Dir["build/*"].find { |f| File.executable?(f) && !File.directory?(f) } => "Network-Scanner"
    end
  end

  test do
    assert_predicate bin/"Network-Scanner", :exist?
    assert_predicate bin/"Network-Scanner", :executable?
  end
end
