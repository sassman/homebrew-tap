class Amoxide < Formula
  desc "Shell alias manager — manage aliases globally via profiles or per-project"
  homepage "https://github.com/sassman/amoxide-rs"
  version "0.4.0"
  if OS.mac?
    if Hardware::CPU.arm?
      url "https://github.com/sassman/amoxide-rs/releases/download/v0.4.0/amoxide-aarch64-apple-darwin.tar.xz"
      sha256 "54a9db43a43a1a14946dc77d91b3562121bf4cc126f5d12a3939ad4e835dc23f"
    end
    if Hardware::CPU.intel?
      url "https://github.com/sassman/amoxide-rs/releases/download/v0.4.0/amoxide-x86_64-apple-darwin.tar.xz"
      sha256 "bc669884040b88d1ed6a06eda89cd2a3daa6948dee5e00fbb6927b6ffb33f162"
    end
  end
  if OS.linux?
    if Hardware::CPU.arm?
      url "https://github.com/sassman/amoxide-rs/releases/download/v0.4.0/amoxide-aarch64-unknown-linux-gnu.tar.xz"
      sha256 "b7d5ba9bc226e6ab47eea126daf5c18694401f303dc1f9fbca14ede57fc7d786"
    end
    if Hardware::CPU.intel?
      url "https://github.com/sassman/amoxide-rs/releases/download/v0.4.0/amoxide-x86_64-unknown-linux-gnu.tar.xz"
      sha256 "90cfe7f32a72d88d999ec3312dba3c1dea85228bbd9025e425ffde767f11310a"
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
    bin.install "am" if OS.mac? && Hardware::CPU.arm?
    bin.install "am" if OS.mac? && Hardware::CPU.intel?
    bin.install "am" if OS.linux? && Hardware::CPU.arm?
    bin.install "am" if OS.linux? && Hardware::CPU.intel?

    install_binary_aliases!

    # Homebrew will automatically install these, so we don't need to do that
    doc_files = Dir["README.*", "readme.*", "LICENSE", "LICENSE.*", "CHANGELOG.*"]
    leftover_contents = Dir["*"] - doc_files

    # Install any leftover files in pkgshare; these are probably config or
    # sample files.
    pkgshare.install(*leftover_contents) unless leftover_contents.empty?
  end
end
