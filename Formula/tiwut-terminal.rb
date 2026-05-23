class TiwutTerminal < Formula
  desc "Ultra-fast, cross-platform command-line emulator built in C++ and Qt 6"
  homepage "https://github.com/tiwut/Tiwut-Terminal"
  version "2.3.3"
  license "MIT"

  if OS.mac?
    url "https://codeload.github.com/tiwut/Tiwut-Terminal/tar.gz/refs/tags/v2.3.3"
    sha256 "d8016ed97253e660d7f64228be47b239e94a6978f631eb30d48ad14a2133cd9f"
    
    depends_on "cmake" => :build
    depends_on "qt"
  elsif OS.linux?
    url "https://github.com/tiwut/Tiwut-Terminal/releases/download/v2.3.3/Tiwut_Terminal-x86_64.AppImage"
    sha256 "d8016ed97253e660d7f64228be47b239e94a6978f631eb30d48ad14a2133cd9f"
  end

  def install
    if OS.mac?
      system "cmake", "-S", ".", "-B", "build", *std_cmake_args
      system "cmake", "--build", "build"
      
      bin.install "build/Tiwut-Terminal"
    elsif OS.linux?
      appimage = Dir["*.AppImage"].first
      bin.install appimage => "Tiwut-Terminal"
    end
    
    (bin/"exec").mkpath
  end

  test do
    assert_match "Welcome to Tiwut Terminal", shell_output("echo 'exit' | #{bin}/Tiwut-Terminal --cli")
  end
end
