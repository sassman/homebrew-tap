cask "display-align" do
  version "1.2.0"
  sha256 "7cdab3d59881130ac7d3e14a1ccd490d06e52285bbeaa4a36ab283e4853a9d3a"

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
