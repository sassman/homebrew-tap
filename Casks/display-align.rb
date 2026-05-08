cask "display-align" do
  version "1.5.0"
  sha256 "b297c6fd28273c8b19893e8c738f4bb21bda44fb5338a721c7f8b9b4619bfab7"

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
