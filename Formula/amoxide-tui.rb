class AmoxideTui < Formula
  desc "Interactive TUI for amoxide — manage aliases and profiles visually"
  homepage "https://github.com/sassman/amoxide-rs"
  version "0.10.4"
  if OS.mac?
    if Hardware::CPU.arm?
      url "https://github.com/sassman/amoxide-rs/releases/download/v0.10.4/amoxide-tui-aarch64-apple-darwin.tar.xz"
      sha256 "0ac2621c737667ae04d31a3651d514ff0e1cd2967b0e339716553e2d47821ba2"
    end
    if Hardware::CPU.intel?
      url "https://github.com/sassman/amoxide-rs/releases/download/v0.10.4/amoxide-tui-x86_64-apple-darwin.tar.xz"
      sha256 "d906d097246d3c310cf59899a51d3e75955d515bac219aa9c662b1b8cdd5c3b1"
    end
  end
  if OS.linux?
    if Hardware::CPU.arm?
      url "https://github.com/sassman/amoxide-rs/releases/download/v0.10.4/amoxide-tui-aarch64-unknown-linux-gnu.tar.xz"
      sha256 "9802ba6f856a3aae335c8a97f64c4352fdb208a170bca63deb8bddee1133231f"
    end
    if Hardware::CPU.intel?
      url "https://github.com/sassman/amoxide-rs/releases/download/v0.10.4/amoxide-tui-x86_64-unknown-linux-gnu.tar.xz"
      sha256 "a85a9bbffe4f40e722dc898ef536f19d4cc12b7739e9360fdff7217fa12887d0"
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
