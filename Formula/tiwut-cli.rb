class TiwutCli < Formula
  desc "Tiwut Terminal TUI Desktop Dashboard"
  homepage "https://github.com/tiwut/Tiwut-CLI"
  url "https://github.com/tiwut/Tiwut-CLI/archive/refs/tags/v1.1.1.tar.gz"
  sha256 "e3b0c44298fc1c149afbf4c8996fb92427ae41e4649b934ca495991b7852b855"
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
