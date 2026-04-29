cask "display-align" do
  version "1.1.0"
  sha256 "dfb437010f79c18aab5bb2cfc44e6bb1e0936290142cd3c1f12c69ddaf6a14c8"

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
