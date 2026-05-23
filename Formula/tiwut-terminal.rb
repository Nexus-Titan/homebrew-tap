class TiwutTerminal < Formula
  desc "Ultra-fast, cross-platform command-line emulator built in C++ and Qt 6"
  homepage "https://github.com/tiwut/Tiwut-Terminal"
  url "https://codeload.github.com/tiwut/Tiwut-Terminal/tar.gz/refs/tags/v2.3.3"
  sha256 "d8016ed97253e660d7f64228be47b239e94a6978f631eb30d48ad14a2133cd9f"
  license "MIT"
  version "2.3.3" 
  
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
