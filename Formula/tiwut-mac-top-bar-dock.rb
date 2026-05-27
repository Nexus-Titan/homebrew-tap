class MacTopBarDock < Formula
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

    app "#{app_bundle}"
  end

  def caveats
    <<~EOS
      The app has been successfully installed and symlinked into your Applications folder.
      You can open it from your Applications folder or launch it via Spotlight.

      The first time you run it, the app will create a folder at:
        ~/DockDesktop
      Simply drop your favorite applications, folders, or files (aliases work great!) inside.
    EOS
  end

  test do
    assert_predicate prefix/"Top Bar Dock.app/Contents/MacOS/TopBarDock", :exist?
  end
end
