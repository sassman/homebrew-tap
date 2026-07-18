class Amoxide < Formula
  desc "Shell alias manager — manage aliases globally via profiles or per-project"
  homepage "https://github.com/sassman/amoxide-rs"
  version "0.10.5"
  if OS.mac?
    if Hardware::CPU.arm?
      url "https://github.com/sassman/amoxide-rs/releases/download/v0.10.5/amoxide-aarch64-apple-darwin.tar.xz"
      sha256 "cd792e26e46c7a762ad9184d28f3e543608e1603e3f7c59149650bddcc89a436"
    end
    if Hardware::CPU.intel?
      url "https://github.com/sassman/amoxide-rs/releases/download/v0.10.5/amoxide-x86_64-apple-darwin.tar.xz"
      sha256 "632536dbb45906af5303eb71d92919044ec634de814bb8a5032a3356132fdae2"
    end
  end
  if OS.linux?
    if Hardware::CPU.arm?
      url "https://github.com/sassman/amoxide-rs/releases/download/v0.10.5/amoxide-aarch64-unknown-linux-gnu.tar.xz"
      sha256 "5477cecc94bf310644bdb11e37a7425ecc8e31724b7e1a6aee7660c88470b3e2"
    end
    if Hardware::CPU.intel?
      url "https://github.com/sassman/amoxide-rs/releases/download/v0.10.5/amoxide-x86_64-unknown-linux-gnu.tar.xz"
      sha256 "1635da50f8a8c3bc7fe34d8b6aa3edcf9bb2593234524bd221d3b00d68e9d2e4"
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
