class Diffie < Formula
  desc "Fast diff review tool"
  homepage "https://github.com/sassman/diffie-rs"
  version "0.3.0"
  if OS.mac?
    if Hardware::CPU.arm?
      url "https://github.com/sassman/diffie-rs/releases/download/v0.3.0/diffie-aarch64-apple-darwin.tar.xz"
      sha256 "7d2b46e0e57a9bbee55004ea6530bf75645a076bd0de47f50f24222411ee670b"
    end
    if Hardware::CPU.intel?
      url "https://github.com/sassman/diffie-rs/releases/download/v0.3.0/diffie-x86_64-apple-darwin.tar.xz"
      sha256 "38becc89cfd7243695ecc2af4dfaac085d1962126e16836eef3003ebbd0da0fd"
    end
  end
  if OS.linux? && Hardware::CPU.intel?
    url "https://github.com/sassman/diffie-rs/releases/download/v0.3.0/diffie-x86_64-unknown-linux-gnu.tar.xz"
    sha256 "c3cd95dd9a5a5bd7a5824a9da0a41e0e1b3e702c3add67e9750e41893c40c53b"
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
