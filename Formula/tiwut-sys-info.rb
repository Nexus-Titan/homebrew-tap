class TiwutSysInfo < Formula
  desc "Comprehensive vertical system information script for Unix-like OSs"
  homepage "https://github.com/tiwut/Tiwut-Sys-Info"
  url "https://github.com/tiwut/Tiwut-Sys-Info/archive/refs/tags/v1.1.1.tar.gz"
  sha256 "ae8c05c442a2e19c6f6b8e046ca439bc533c5c407eb6cc37a74e0ea12d480c62"
  license "MIT"

  def install
    bin.install "tiwut-sys-info.sh" => "tiwut-sys-info"
  end

  test do
    assert_match "Tiwut Sys Info", shell_output("#{bin}/tiwut-sys-info", 0)
  end
end
