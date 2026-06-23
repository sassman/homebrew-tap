class AmoxideTui < Formula
  desc "Interactive TUI for amoxide — manage aliases and profiles visually"
  homepage "https://github.com/sassman/amoxide-rs"
  version "0.10.1"
  if OS.mac?
    if Hardware::CPU.arm?
      url "https://github.com/sassman/amoxide-rs/releases/download/v0.10.1/amoxide-tui-aarch64-apple-darwin.tar.xz"
      sha256 "9d58fc72c554a5dbced3bc40884225008121861083c39446202bb80daac2be2d"
    end
    if Hardware::CPU.intel?
      url "https://github.com/sassman/amoxide-rs/releases/download/v0.10.1/amoxide-tui-x86_64-apple-darwin.tar.xz"
      sha256 "8afeb3dee32453ed423bf1890559e9ee0c67940caa59936c30cc6d0331ced769"
    end
  end
  if OS.linux?
    if Hardware::CPU.arm?
      url "https://github.com/sassman/amoxide-rs/releases/download/v0.10.1/amoxide-tui-aarch64-unknown-linux-gnu.tar.xz"
      sha256 "4776a4d7d3a2c4925cda38a459990db9b0e98432e10ea44d66ceb98490ccf57e"
    end
    if Hardware::CPU.intel?
      url "https://github.com/sassman/amoxide-rs/releases/download/v0.10.1/amoxide-tui-x86_64-unknown-linux-gnu.tar.xz"
      sha256 "2cc6ff658225d51a8c1e0ba835c7718c4027811921064e6a8af5cafb6eed3eef"
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
