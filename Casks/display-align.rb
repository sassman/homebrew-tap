cask "display-align" do
  version "1.0.1"
  sha256 "3e20daef4065a19606439b8afa057d9ad37e33bd181287aeabd2c0516f3c2e65"

  url "https://github.com/sassman/display-align/releases/download/v#{version}/DisplayAlign-v#{version}.zip"
  name "DisplayAlign"
  desc "Automatic display arrangement for macOS"
  homepage "https://github.com/sassman/display-align"

  depends_on macos: ">= :sonoma"

  app "DisplayAlign.app"

  zap trash: [
    "~/.config/display-align",
  ]
end
