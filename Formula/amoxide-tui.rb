class AmoxideTui < Formula
  desc "Interactive TUI for amoxide — manage aliases and profiles visually"
  homepage "https://github.com/sassman/amoxide-rs"
  version "0.9.0"
  if OS.mac?
    if Hardware::CPU.arm?
      url "https://github.com/sassman/amoxide-rs/releases/download/v0.9.0/amoxide-tui-aarch64-apple-darwin.tar.xz"
      sha256 "80f2974ce8a783cd41fa2d2f18e20d0d57b4ad559b825af336c771af93049a6e"
    end
    if Hardware::CPU.intel?
      url "https://github.com/sassman/amoxide-rs/releases/download/v0.9.0/amoxide-tui-x86_64-apple-darwin.tar.xz"
      sha256 "4b5c6230bba64297357a5b23e1a36fce5f8cb710dcde4d31af0db5c6363dd714"
    end
  end
  if OS.linux?
    if Hardware::CPU.arm?
      url "https://github.com/sassman/amoxide-rs/releases/download/v0.9.0/amoxide-tui-aarch64-unknown-linux-gnu.tar.xz"
      sha256 "2204258bdb14c4ba92b798f3cd329c8b31eb55d495089c6afa40141e0fb56bdd"
    end
    if Hardware::CPU.intel?
      url "https://github.com/sassman/amoxide-rs/releases/download/v0.9.0/amoxide-tui-x86_64-unknown-linux-gnu.tar.xz"
      sha256 "11c627e98652fea4e018358d57bfcab0033f8bd2a6876ba196d49a6da7c8c1e8"
    end
  end
  license "GPL-3.0-only"

  BINARY_ALIASES = {
    "aarch64-apple-darwin":               {},
    "aarch64-unknown-linux-gnu":          {},
    "aarch64-unknown-linux-musl-dynamic": {},
    "aarch64-unknown-linux-musl-static":  {},
    "x86_64-apple-darwin":                {},
    "x86_64-pc-windows-gnu":              {},
    "x86_64-unknown-linux-gnu":           {},
    "x86_64-unknown-linux-musl-dynamic":  {},
    "x86_64-unknown-linux-musl-static":   {},
  }.freeze

  def target_triple
    cpu = Hardware::CPU.arm? ? "aarch64" : "x86_64"
    os = OS.mac? ? "apple-darwin" : "unknown-linux-gnu"

    "#{cpu}-#{os}"
  end

  def install_binary_aliases!
    BINARY_ALIASES[target_triple.to_sym].each do |source, dests|
      dests.each do |dest|
        bin.install_symlink bin/source.to_s => dest
      end
    end
  end

  def install
    bin.install "am-tui" if OS.mac? && Hardware::CPU.arm?
    bin.install "am-tui" if OS.mac? && Hardware::CPU.intel?
    bin.install "am-tui" if OS.linux? && Hardware::CPU.arm?
    bin.install "am-tui" if OS.linux? && Hardware::CPU.intel?

    install_binary_aliases!

    # Homebrew will automatically install these, so we don't need to do that
    doc_files = Dir["README.*", "readme.*", "LICENSE", "LICENSE.*", "CHANGELOG.*"]
    leftover_contents = Dir["*"] - doc_files

    # Install any leftover files in pkgshare; these are probably config or
    # sample files.
    pkgshare.install(*leftover_contents) unless leftover_contents.empty?
  end
end
