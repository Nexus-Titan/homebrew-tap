class Nexus4 < Formula
  desc "C++ based interpreter for the Nexus language"
  homepage "https://tiwut.org/nexus"
  url "https://github.com/Nexus-Titan/Nexus-the-programming-language/archive/refs/tags/v4.5.1.tar.gz"
  sha256 "70fcbe3189f59f05e53d26b3be391e19210ac03d8bf78eb3c41261379fa73804"
  license "MIT"
  
  depends_on "cmake" => :build
  depends_on "pkg-config" => :build
  depends_on "libx11"
  depends_on "xorgproto"
  depends_on "openssl@3"

  def install
    ENV.append "CXXFLAGS", "-I#{Formula["xorgproto"].opt_include}"
    ENV.append "CXXFLAGS", "-I#{Formula["libx11"].opt_include}"
    args = std_cmake_args + %W[
      -DX11_X11_INCLUDE_PATH=#{Formula["libx11"].opt_include}
      -DX11_X11_LIB=#{Formula["libx11"].opt_lib}/#{shared_library("libX11")}
    ]

    system "cmake", "-S", ".", "-B", "build", *args
    system "cmake", "--build", "build"
    
    bin.install "nexus" => "nexus4"
  end

  test do
    assert_predicate bin/"nexus4", :executable?
  end
end
