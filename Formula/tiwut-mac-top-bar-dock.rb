class TiwutMacTopBarDock < Formula
  desc "Lightning-fast native macOS menu bar app launcher"
  homepage "https://github.com/tiwut/Mac-Top-Bar-Dock"
  url "https://github.com/tiwut/Mac-Top-Bar-Dock/archive/refs/tags/v1.1.1.tar.gz"
  sha256 "cd6786e1de252f9f08b56262b44dd1735d469d2a1aebce5c097212b892bb85d7"
  license "MIT"
  head "https://github.com/tiwut/Mac-Top-Bar-Dock.git", branch: "main"

  def install
    system "clang++", "-std=c++17", "-Wall", "-fobjc-arc",
           "-framework", "Cocoa", "-framework", "QuartzCore",
           "TopBarDock.mm", "-o", "TopBarDock"

    app_bundle = "Top Bar Dock.app"
    mkdir_p "#{app_bundle}/Contents/MacOS"
    
    mv "TopBarDock", "#{app_bundle}/Contents/MacOS/TopBarDock"

    prefix.install app_bundle

    (bin/"tiwut-mac-top-bar-dock").write <<~SH
      #!/bin/sh
      exec "#{opt_prefix}/Top Bar Dock.app/Contents/MacOS/TopBarDock" "$@"
    SH
  end

  def caveats
    <<~EOS
      The app has been successfully installed!

      You can run the app directly from your terminal using:
        tiwut-mac-top-bar-dock

      Or you can symlink the app to your /Applications folder to launch it visually:
        ln -sf "#{opt_prefix}/Top Bar Dock.app" /Applications/

      The first time you run it, the app will create a folder at:
        ~/DockDesktop
      Simply drop your favorite applications, folders, or files (aliases work great!) inside.
    EOS
  end

  test do
    assert_predicate prefix/"Top Bar Dock.app/Contents/MacOS/TopBarDock", :exist?
    assert_predicate bin/"tiwut-mac-top-bar-dock", :exist?
  end
end
