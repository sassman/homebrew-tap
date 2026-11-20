class AmoxideTui < Formula
  desc "Interactive TUI for amoxide — manage aliases and profiles visually"
  homepage "https://github.com/sassman/amoxide-rs"
  version "0.10.9"
  if OS.mac?
    if Hardware::CPU.arm?
      url "https://github.com/sassman/amoxide-rs/releases/download/v0.10.9/amoxide-tui-aarch64-apple-darwin.tar.xz"
      sha256 "1ee0b14674d7f4a11e5d662dc00f05daccd583e4f17a891c5c5614fe95f261c7"
    end
    if Hardware::CPU.intel?
      url "https://github.com/sassman/amoxide-rs/releases/download/v0.10.9/amoxide-tui-x86_64-apple-darwin.tar.xz"
      sha256 "db4dc50467ae28ced563b52b2b0cfc45fee74a3a815d565beb46be07018bad21"
    end
  end
  if OS.linux?
    if Hardware::CPU.arm?
      url "https://github.com/sassman/amoxide-rs/releases/download/v0.10.9/amoxide-tui-aarch64-unknown-linux-gnu.tar.xz"
      sha256 "9ebc6d4ba174576b7253757862c6ef2f059ca9933891b575da785fd882636ce3"
    end
    if Hardware::CPU.intel?
      url "https://github.com/sassman/amoxide-rs/releases/download/v0.10.9/amoxide-tui-x86_64-unknown-linux-gnu.tar.xz"
      sha256 "4ef39fedbb2a942a8ec64000dbcb6def8e830a0740480a99eab8dc60c3503dfe"
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
