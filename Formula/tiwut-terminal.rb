class TiwutTerminal < Formula
  desc "Ultra-fast, cross-platform command-line emulator built in C++ and Qt 6"
  homepage "https://github.com/tiwut/Tiwut-Terminal"
  url "https://codeload.github.com/tiwut/Tiwut-Terminal/tar.gz/refs/tags/v2.3.2"
  sha256 "REPLACE_WITH_ACTUAL_SHA256"
  license "MIT"

  depends_on "cmake" => :build
  depends_on "qt"

  def install
    system "cmake", "-S", ".", "-B", "build", *std_cmake_args
    system "cmake", "--build", "build"
    
    bin.install "build/Tiwut-Terminal"
    
    (bin/"exec").mkpath
  end

  test do
    assert_match "Welcome to Tiwut Terminal", shell_output("echo 'exit' | #{bin}/Tiwut-Terminal --cli")
  end
end
