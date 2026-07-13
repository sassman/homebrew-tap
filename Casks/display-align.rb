cask "display-align" do
  version "1.6.1"
  sha256 "299c700b1874ea6ee6a2429ddf4e3924973b7b661eb0b3d11c7a8ad49469fe3e"

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
