cask "display-align" do
  version "1.7.1"
  sha256 "453178a69e08ceb4e662900fad41aa602dcffeca0915b0e9ca8714b57c08815f"

  url "https://github.com/sassman/display-align/releases/download/v#{version}/DisplayAlign-v#{version}.zip"
  name "DisplayAlign"
  desc "Automatic display arrangement for macOS"
  homepage "https://github.com/sassman/display-align"

  depends_on macos: :sonoma

  app "DisplayAlign.app"

  zap trash: [
    "~/.config/display-align",
  ]
end
