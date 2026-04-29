cask "display-align" do
  version "1.3.0"
  sha256 "68e63d3af89e3896efa2da3e7353aa11b79588ef44efbae5948643e6265f5062"

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
