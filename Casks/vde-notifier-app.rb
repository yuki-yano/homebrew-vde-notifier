cask "vde-notifier-app" do
  version "0.1.3"
  sha256 "3d64934929a1affc18b455d76b016949d07ad9c53bcf94072eb89742e9b6bbed"

  url "https://github.com/yuki-yano/vde-notifier/releases/download/app-v#{version}/VdeNotifierApp.app.tar.gz"
  name "VdeNotifierApp"
  desc "Swift notification backend for vde-notifier"
  homepage "https://github.com/yuki-yano/vde-notifier"

  livecheck do
    url :url
    regex(/^app-v(\d+(?:\.\d+)+)$/i)
    strategy :github_releases
  end

  depends_on macos: ">= :sonoma"

  app "VdeNotifierApp.app"
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
