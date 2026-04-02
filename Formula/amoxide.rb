class Amoxide < Formula
  desc "Shell alias manager — manage aliases globally via profiles or per-project"
  homepage "https://github.com/sassman/amoxide-rs"
  version "0.3.0"
  if OS.mac?
    if Hardware::CPU.arm?
      url "https://github.com/sassman/amoxide-rs/releases/download/v0.3.0/amoxide-aarch64-apple-darwin.tar.xz"
      sha256 "846fd89da8dea2e01d2cba6e1c65182544e4fe57772660aa91201fc4e77cd467"
    end
    if Hardware::CPU.intel?
      url "https://github.com/sassman/amoxide-rs/releases/download/v0.3.0/amoxide-x86_64-apple-darwin.tar.xz"
      sha256 "0fb4ae68f8eb908f0444d0d49fceaaddeb61e1eb82aa9c1997500e3bf7ffecac"
    end
  end
  if OS.linux?
    if Hardware::CPU.arm?
      url "https://github.com/sassman/amoxide-rs/releases/download/v0.3.0/amoxide-aarch64-unknown-linux-gnu.tar.xz"
      sha256 "9537fa0f62f43b1296c8c1f4ff7faf907774ab5de8d9dfec51d462b372f19468"
    end
    if Hardware::CPU.intel?
      url "https://github.com/sassman/amoxide-rs/releases/download/v0.3.0/amoxide-x86_64-unknown-linux-gnu.tar.xz"
      sha256 "cf4056d107a397276dc91330c25673dbda2d13c75ecca86007f6787bfa755b9d"
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
