cask "display-align" do
  version "1.7.0"
  sha256 "30df31b8d371fe051841eca5d0ca47aa315491dfa7319837e581b08ce6950c2c"

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
