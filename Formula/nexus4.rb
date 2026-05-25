class Nexus4 < Formula
  desc "C++ based interpreter for the Nexus language"
  homepage "https://tiwut.org/nexus"
  url "https://github.com/Nexus-Titan/Nexus-the-programming-language/archive/refs/tags/v4.5.0.tar.gz"
  sha256 "94c8456e808f4ac657cc384bb812f07ce4adc1d1703199eda1b8f502ca7ebc80"
  license "MIT"
  
  depends_on "cmake" => :build
  depends_on "pkg-config" => :build
  depends_on "xorgproto"
  depends_on "libx11"
  depends_on "openssl@3"

  def install
    args = std_cmake_args + %W[
      -DX11_X11_INCLUDE_PATH=#{HOMEBREW_PREFIX}/include
      -DX11_X11_LIB=#{HOMEBREW_PREFIX}/lib/#{shared_library("libX11")}
    ]

    system "cmake", "-S", ".", "-B", "build", *args
    system "cmake", "--build", "build"
    
    bin.install "nexus" => "nexus4"
  end

  test do
    assert_predicate bin/"nexus4", :executable?
  end
end
