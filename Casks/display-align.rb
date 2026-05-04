cask "display-align" do
  version "1.4.0"
  sha256 "e79e9ff27396bfb4d646056ac2ecd89a8a8357629d5e6d1ce41a43228aaac8a6"

  url "https://github.com/sassman/display-align/releases/download/v#{version}/DisplayAlign-v#{version}.dmg"
  name "DisplayAlign"
  desc "Automatic display arrangement for macOS"
  homepage "https://github.com/sassman/display-align"

  depends_on macos: ">= :sonoma"

  app "DisplayAlign.app"

  zap trash: [
    "~/.config/display-align",
  ]
end
