cask "vde-notifier-app" do
  version :latest
  sha256 :no_check

  url "https://github.com/yuki-yano/vde-notifier/releases/latest/download/VdeNotifierApp.app.tar.gz"
  name "VdeNotifierApp"
  desc "Swift notification backend for vde-notifier"
  homepage "https://github.com/yuki-yano/vde-notifier"

  depends_on macos: ">= :sonoma"

  app "VdeNotifierApp.app"
  binary "#{appdir}/VdeNotifierApp.app/Contents/MacOS/vde-notifier-app"

  uninstall quit: "com.yuki-yano.vde-notifier-app.agent"

  zap trash: [
    "~/Library/Application Support/vde-notifier-app",
    "~/Library/Preferences/com.yuki-yano.vde-notifier-app.agent.plist",
  ]
end
