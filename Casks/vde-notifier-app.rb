cask "vde-notifier-app" do
  version "0.2.1"
  sha256 "6bb647cbef0e88cc5b03a96c5567e5fd4e695533d8cecbd1daced9e3ca882cd9"

  url "https://github.com/yuki-yano/vde-notifier/releases/download/app-v#{version}/VdeNotifierApp.app.tar.gz"
  name "VdeNotifierApp"
  desc "Swift tmux notification CLI and resident agent"
  homepage "https://github.com/yuki-yano/vde-notifier"

  livecheck do
    url :url
    regex(/^app-v(\d+(?:\.\d+)+)$/i)
    strategy :github_releases
  end

  depends_on macos: :sonoma

  app "VdeNotifierApp.app"
  binary "#{appdir}/VdeNotifierApp.app/Contents/MacOS/vde-notifier"
  binary "#{appdir}/VdeNotifierApp.app/Contents/MacOS/vde-notifier-app"

  uninstall quit: "com.yuki-yano.vde-notifier-app.agent"

  zap trash: [
    "~/Library/Application Support/vde-notifier-app",
    "~/Library/Preferences/com.yuki-yano.vde-notifier-app.agent.plist",
  ]

  caveats <<~EOS
    This app is not currently signed or notarized with an Apple Developer ID.
    If macOS blocks launch, run:
      xattr -dr com.apple.quarantine /Applications/VdeNotifierApp.app
  EOS
end
