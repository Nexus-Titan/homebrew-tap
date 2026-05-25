class Nexus4 < Formula
  desc "C++ based interpreter for the Nexus language"
  homepage "https://tiwut.org/nexus"
  url "https://github.com/Nexus-Titan/Nexus-the-programming-language/archive/refs/tags/v4.5.0.tar.gz"
  sha256 "94c8456e808f4ac657cc384bb812f07ce4adc1d1703199eda1b8f502ca7ebc80"
  license "MIT"
  
  depends_on "cmake" => :build
  depends_on "openssl@3"
  def install
    openssl = Formula["openssl@3"]

    cmake_args = std_cmake_args + [
      "-DCMAKE_BUILD_TYPE=Release",
      "-DOPENSSL_ROOT_DIR=#{openssl.opt_prefix}",
      "-DOPENSSL_INCLUDE_DIR=#{openssl.opt_include}",
      "-DOPENSSL_LIBRARIES=#{openssl.opt_lib}",
    ]


    x11_include_candidates = [
      "/usr/include",
      "/usr/local/include",
      "/opt/X11/include",
    ]

    x11_lib_candidates = [
      "/usr/lib/x86_64-linux-gnu",
      "/usr/lib/aarch64-linux-gnu",
      "/usr/lib64",
      "/usr/lib",
      "/usr/local/lib",
      "/opt/X11/lib",
    ]

    x11_include = x11_include_candidates.find { |d| File.exist?("#{d}/X11/Xlib.h") }
    x11_lib     = x11_lib_candidates.find do |d|
      File.exist?("#{d}/libX11.so") ||
        File.exist?("#{d}/libX11.so.6") ||
        File.exist?("#{d}/libX11.dylib")
    end

    unless x11_include
      odie <<~EOS
        -
    ##########################################################################
    ##########################################################################
    ##                                                                      ##
    ##  X11 development headers not found (missing X11/Xlib.h).             ##
    ##  Install the X11 dev package from your system package manager first: ##
    ##----------------------------------------------------------------------##
    ##    Debian / Ubuntu:  sudo apt install libx11-dev                     ##
    ##    Fedora / RHEL:    sudo dnf install libX11-devel                   ##
    ##    Arch / Manjaro:   sudo pacman -S libx11                           ##
    ##    macOS:            install XQuartz from https://www.xquartz.org    ##
    ##                                                                      ##
    ##########################################################################
    ##########################################################################
        -
      EOS
    end

    unless x11_lib
      odie <<~EOS
        -
    ##########################################################################
    ##########################################################################
    ##                                                                      ##
    ##  libX11 shared library not found.                                    ##
    ##  Install the X11 dev package fromyour system package manager first:  ##
    ##----------------------------------------------------------------------##
    ##    Debian / Ubuntu:  sudo apt install libx11-dev                     ##
    ##    Fedora / RHEL:    sudo dnf install libX11-devel                   ##
    ##    Arch / Manjaro:   sudo pacman -S libx11                           ##
    ##    macOS:            install XQuartz from https://www.xquartz.org    ##
    ##                                                                      ##
    ##########################################################################
    ##########################################################################
        -
      EOS
    end

    x11_lib_file = ["libX11.so", "libX11.so.6", "libX11.dylib"]
                   .map { |f| "#{x11_lib}/#{f}" }
                   .find { |f| File.exist?(f) }

    cmake_args += [
      "-DX11_X11_INCLUDE_PATH=#{x11_include}",
      "-DX11_X11_LIB=#{x11_lib_file}",
    ]

    system "cmake", "-S", ".", "-B", "build", *cmake_args
    system "cmake", "--build", "build", "--config", "Release"

    bin.install "nexus" => "nexus4"

    doc.install "README.md", "SYNTAX.md"
    (share/"nexus4/Samples").install Dir["Samples/*"] if File.directory?("Samples")
  end

  test do
    # Write a minimal Nexus script and verify the interpreter handles it
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
