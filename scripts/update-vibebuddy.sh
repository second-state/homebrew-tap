#!/usr/bin/env bash
# Points Casks/vibebuddy.rb at the latest VibeBuddy release: its version and the DMG's sha256.
# Reads the release through the GitHub API (gh), so it needs no download. Prints the version it wrote.
set -euo pipefail

repo="second-state/vibebuddy"
cask="$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd)/Casks/vibebuddy.rb"

tag="$(gh release view --repo "${repo}" --json tagName --jq .tagName)"
version="${tag#v}"
digest="$(gh api "repos/${repo}/releases/tags/${tag}" \
    --jq ".assets[] | select(.name == \"VibeBuddy-${tag}-arm64.dmg\") | .digest")"
[[ "${digest}" == sha256:* ]] || { echo "no arm64 DMG with a digest in ${tag}" >&2; exit 1; }

cat > "${cask}" <<CASK
cask "vibebuddy" do
  version "${version}"
  sha256 "${digest#sha256:}"

  url "https://github.com/${repo}/releases/download/v#{version}/VibeBuddy-v#{version}-arm64.dmg"
  name "VibeBuddy"
  desc "Desk companion that announces what your AI coding agents are doing"
  homepage "https://github.com/${repo}"

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
CASK
echo "${version}"
