cask "vibebuddy" do
  version "0.6.2"
  sha256 "c2859e95f683c11a63fe047a27ef75ebaa3999a54e2383219b45aa574b23184d"

  url "https://github.com/second-state/vibebuddy/releases/download/v#{version}/VibeBuddy-v#{version}-arm64.dmg"
  name "VibeBuddy"
  desc "Desk companion that announces what your AI coding agents are doing"
  homepage "https://github.com/second-state/vibebuddy"

  livecheck do
    url :url
    strategy :github_latest
  end

  # The app updates itself with Sparkle.
  auto_updates true
  depends_on arch: :arm64
  depends_on macos: :sonoma

  app "VibeBuddy.app"

  uninstall quit: "com.vibebuddy.app"

  zap trash: [
    "~/Library/Application Support/VibeBuddy",
    "~/Library/Caches/com.vibebuddy.app",
    "~/Library/HTTPStorages/com.vibebuddy.app",
    "~/Library/Logs/VibeBuddy",
    "~/Library/Preferences/com.vibebuddy.app.plist",
  ]

  caveats <<~EOS
    Remove VibeBuddy's hooks from your agents (Settings > Agents > Remove) before uninstalling.
  EOS
end
