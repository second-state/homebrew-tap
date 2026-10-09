cask "vibebuddy" do
  version "0.4.1"
  sha256 "d48c1d3d228e39c42a2684b203123bfc0f5b6adc49d851847945efcca33ab21e"

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
