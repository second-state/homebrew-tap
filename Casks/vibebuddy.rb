cask "vibebuddy" do
  version "0.4.2"
  sha256 "38e6d29e3ef6c387d4fd646bca7cdf3bab693d6138f86c9d765b9936094f2e0c"

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
