class AmoxideTui < Formula
  desc "Interactive TUI for amoxide — manage aliases and profiles visually"
  homepage "https://github.com/sassman/amoxide-rs"
  version "0.10.7"
  if OS.mac?
    if Hardware::CPU.arm?
      url "https://github.com/sassman/amoxide-rs/releases/download/v0.10.7/amoxide-tui-aarch64-apple-darwin.tar.xz"
      sha256 "8a655f1611ee6f5c0b518ebd27fd58710521ec3d1df891e154e8ddf4da9324c5"
    end
    if Hardware::CPU.intel?
      url "https://github.com/sassman/amoxide-rs/releases/download/v0.10.7/amoxide-tui-x86_64-apple-darwin.tar.xz"
      sha256 "91615e77f632d5736a66b1544ab3260fb1b3c7e25cab46fbf1d2ac00d99c53ad"
    end
  end
  if OS.linux?
    if Hardware::CPU.arm?
      url "https://github.com/sassman/amoxide-rs/releases/download/v0.10.7/amoxide-tui-aarch64-unknown-linux-gnu.tar.xz"
      sha256 "88dabf58b7481fd294a0f88a0c1cc8df62bc2728540c4206f41e49bcc4253a31"
    end
    if Hardware::CPU.intel?
      url "https://github.com/sassman/amoxide-rs/releases/download/v0.10.7/amoxide-tui-x86_64-unknown-linux-gnu.tar.xz"
      sha256 "ea67e2176d5eb0b0651a8d9bc2c562985376f6d6cf5ea8dd71173186f4525f01"
    end
  end
  license "GPL-3.0-only"

  BINARY_ALIASES = {
    "aarch64-apple-darwin":               {},
    "aarch64-pc-windows-gnu":             {},
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
    if OS.mac? && Hardware::CPU.arm?
      bin.install "am-tui"
    end
    if OS.mac? && Hardware::CPU.intel?
      bin.install "am-tui"
    end
    if OS.linux? && Hardware::CPU.arm?
      bin.install "am-tui"
    end
    if OS.linux? && Hardware::CPU.intel?
      bin.install "am-tui"
    end

    install_binary_aliases!

    # Homebrew will automatically install these, so we don't need to do that
    doc_files = Dir["README.*", "readme.*", "LICENSE", "LICENSE.*", "CHANGELOG.*"]
    leftover_contents = Dir["*"] - doc_files

    # Install any leftover files in pkgshare; these are probably config or
    # sample files.
    pkgshare.install(*leftover_contents) unless leftover_contents.empty?
  end
end
