cask "vibebuddy" do
  version "0.6.3"
  sha256 "6f57c09810f8f13fc8e5e9ec27e09b1155445a6546aa9d5de9da2c078dba124a"

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
