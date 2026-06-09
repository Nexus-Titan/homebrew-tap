class TiwutSysInfo < Formula
  desc "Comprehensive vertical system information script for Unix-like OSs"
  homepage "https://github.com/tiwut/Tiwut-Sys-Info"
  url "https://github.com/tiwut/Tiwut-Sys-Info/archive/refs/tags/v1.1.1.tar.gz"
  sha256 "15f35e21722605e9256ff797ffc2a4cf2a663b329d2bb749ded564aff5332800"
  license "MIT"

  def install
    bin.install "tiwut-sys-info.sh" => "tiwut-sys-info"
  end

  test do
    assert_match "Tiwut Sys Info", shell_output("#{bin}/tiwut-sys-info", 0)
  end
end
