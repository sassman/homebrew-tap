class AmoxideTui < Formula
  desc "Interactive TUI for amoxide — manage aliases and profiles visually"
  homepage "https://github.com/sassman/amoxide-rs"
  version "0.8.0"
  if OS.mac?
    if Hardware::CPU.arm?
      url "https://github.com/sassman/amoxide-rs/releases/download/v0.8.0/amoxide-tui-aarch64-apple-darwin.tar.xz"
      sha256 "5610ff9a3d7bf1b14eaacab4d1dc87d04b2a94901cd467ff8a2e7aa07edd722e"
    end
    if Hardware::CPU.intel?
      url "https://github.com/sassman/amoxide-rs/releases/download/v0.8.0/amoxide-tui-x86_64-apple-darwin.tar.xz"
      sha256 "8d7ee3b64ed28db2e8bb0dfbc7764f1515b51e03cfd45017c701fd1fdcb7ca53"
    end
  end
  if OS.linux?
    if Hardware::CPU.arm?
      url "https://github.com/sassman/amoxide-rs/releases/download/v0.8.0/amoxide-tui-aarch64-unknown-linux-gnu.tar.xz"
      sha256 "d738456bfc2ce3257125569f5f40d364081b4a8970d3cd89031851b92501fdd9"
    end
    if Hardware::CPU.intel?
      url "https://github.com/sassman/amoxide-rs/releases/download/v0.8.0/amoxide-tui-x86_64-unknown-linux-gnu.tar.xz"
      sha256 "354dcf3f4dfd33592c62c02885730f7a2572b8468ab14d56ea370a675df2413f"
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
