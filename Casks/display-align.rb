cask "display-align" do
  version "1.0.0"
  sha256 "2993195ced4fd5ae4d5811a65f44157ab28fce320fe9c78366356d129248c7f4"

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
