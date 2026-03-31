class Amoxide < Formula
  desc "Shell alias manager — manage aliases globally via profiles or per-project"
  homepage "https://github.com/sassman/amoxide-rs"
  version "0.2.1"
  if OS.mac?
    if Hardware::CPU.arm?
      url "https://github.com/sassman/amoxide-rs/releases/download/v0.2.1/amoxide-aarch64-apple-darwin.tar.xz"
      sha256 "7c0c3aad90bc4ac42c431b3d288d49ee8526e000addf9489e186640e68b0220b"
    end
    if Hardware::CPU.intel?
      url "https://github.com/sassman/amoxide-rs/releases/download/v0.2.1/amoxide-x86_64-apple-darwin.tar.xz"
      sha256 "64d0cc5e7c3f56ab72773c33ccdf079ae1ea3bb93634376efd1d8c9ebf75550a"
    end
  end
  if OS.linux?
    if Hardware::CPU.arm?
      url "https://github.com/sassman/amoxide-rs/releases/download/v0.2.1/amoxide-aarch64-unknown-linux-gnu.tar.xz"
      sha256 "fe2468e08068b82bff0938f5747de9f748c6b232e549234edfdfcd50acc37fff"
    end
    if Hardware::CPU.intel?
      url "https://github.com/sassman/amoxide-rs/releases/download/v0.2.1/amoxide-x86_64-unknown-linux-gnu.tar.xz"
      sha256 "2a263a18e9d16815c7eba90524dbb59c5d6a90140ae3e8db920adfe2c8616b59"
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
