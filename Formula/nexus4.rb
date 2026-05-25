class Nexus4 < Formula
  desc "C++ based interpreter for the Nexus language"
  homepage "https://tiwut.org/nexus"
  url "https://github.com/Nexus-Titan/Nexus-the-programming-language/archive/refs/tags/v4.5.0.tar.gz"
  sha256 "94c8456e808f4ac657cc384bb812f07ce4adc1d1703199eda1b8f502ca7ebc80"
  license "MIT"
  
  depends_on "cmake" => :build
  depends_on "openssl@3"
  on_linux do
    depends_on "libx11"
  end

  on_macos do
  end
  def install
    openssl = Formula["openssl@3"]

    cmake_args = std_cmake_args + [
      "-DCMAKE_BUILD_TYPE=Release",
      "-DOPENSSL_ROOT_DIR=#{openssl.opt_prefix}",
      "-DOPENSSL_INCLUDE_DIR=#{openssl.opt_include}",
      "-DOPENSSL_LIBRARIES=#{openssl.opt_lib}",
    ]
    
    if OS.mac?
      xquartz = "/opt/X11"
      if File.directory?(xquartz)
        cmake_args += [
          "-DX11_INCLUDE_DIR=#{xquartz}/include",
          "-DX11_LIBRARIES=#{xquartz}/lib/libX11.dylib",
        ]
      end
    end

    system "cmake", "-S", ".", "-B", "build", *cmake_args
    system "cmake", "--build", "build", "--config", "Release"

    bin.install "nexus" => "nexus4"

    doc.install "README.md", "SYNTAX.md"
    (share/"nexus4/Samples").install Dir["Samples/*"] if File.directory?("Samples")
  end

  test do
    (testpath/"hello.nx").write <<~NX
      print("Hello from Nexus!")
    NX
    assert_match "Hello from Nexus!", shell_output("#{bin}/nexus4 #{testpath}/hello.nx")
  end

  def caveats
    msg = <<~EOS
      Nexus #{version} has been installed as `nexus4`.

      Run a script:
        nexus4 script.nx

    EOS

    if OS.mac?
      msg += <<~EOS
        ⚠  macOS note: The GUI and networking features rely on X11 (XLib).
           Please install XQuartz if you need GUI windows:
             https://www.xquartz.org
           After installing, log out and back in so DISPLAY is set.
      EOS
    end

    msg
  end
end
