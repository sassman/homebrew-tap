class Diffie < Formula
  desc "Fast diff review tool"
  homepage "https://github.com/sassman/diffie-rs"
  version "0.2.1"
  if OS.mac?
    if Hardware::CPU.arm?
      url "https://github.com/sassman/diffie-rs/releases/download/v0.2.1/diffie-aarch64-apple-darwin.tar.xz"
      sha256 "7f937af4693c4be9d97aaf372fb474122c90e057583e5ce36f407e6091288085"
    end
    if Hardware::CPU.intel?
      url "https://github.com/sassman/diffie-rs/releases/download/v0.2.1/diffie-x86_64-apple-darwin.tar.xz"
      sha256 "d998ecdba25377c91d6d6ee2669de6e0f2bbfb18319d506644708c3f21fedd72"
    end
  end
  if OS.linux? && Hardware::CPU.intel?
    url "https://github.com/sassman/diffie-rs/releases/download/v0.2.1/diffie-x86_64-unknown-linux-gnu.tar.xz"
    sha256 "123f8216d9be3ffddc765ad6e23206aef9bd0e93598cfa68644ece52566430ff"
  end

  BINARY_ALIASES = {
    "aarch64-apple-darwin":     {},
    "x86_64-apple-darwin":      {},
    "x86_64-pc-windows-gnu":    {},
    "x86_64-unknown-linux-gnu": {},
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
      bin.install "diffie"
    end
    if OS.mac? && Hardware::CPU.intel?
      bin.install "diffie"
    end
    if OS.linux? && Hardware::CPU.intel?
      bin.install "diffie"
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
