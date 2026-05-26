class TiwutCli < Formula
  desc "Tiwut Terminal TUI Desktop Dashboard"
  homepage "https://github.com/tiwut/Tiwut-CLI"
  url "https://github.com/tiwut/Tiwut-CLI/archive/refs/tags/v1.1.1.tar.gz"
  sha256 "ae8c05c442a2e19c6f6b8e046ca439bc533c5c407eb6cc37a74e0ea12d480c62"
  head "https://github.com/tiwut/Tiwut-CLI.git", branch: "main"

  depends_on "cmake" => :build
  depends_on "ncurses"

  def install
    system "cmake", "-S", ".", "-B", "build", *std_cmake_args
    system "cmake", "--build", "build"
    system "cmake", "--install", "build"

    pkgshare.install "desktop"
  end

  def caveats
    <<~EOS
      The Tiwut-CLI application assets and default desktop shortcuts have been
      installed to Homebrew's share directory:
        #{opt_share}/tiwut-cli/desktop
      The application binary will automatically query this directory on startup.
    EOS
  end

  test do
    system "#{bin}/Tiwut-CLI", "--help"
  end
end
