class Amoxide < Formula
  desc "Shell alias manager — manage aliases globally via profiles or per-project"
  homepage "https://github.com/sassman/amoxide-rs"
  version "0.9.1"
  if OS.mac?
    if Hardware::CPU.arm?
      url "https://github.com/sassman/amoxide-rs/releases/download/v0.9.1/amoxide-aarch64-apple-darwin.tar.xz"
      sha256 "b1db2e938295f3d385a3932f1e04a07246a52823f354fee4273565974c863e1b"
    end
    if Hardware::CPU.intel?
      url "https://github.com/sassman/amoxide-rs/releases/download/v0.9.1/amoxide-x86_64-apple-darwin.tar.xz"
      sha256 "0cf285fc8c95ab578a19181a20841ce429bc7038c9e26215bb7ac059dee500df"
    end
  end
  if OS.linux?
    if Hardware::CPU.arm?
      url "https://github.com/sassman/amoxide-rs/releases/download/v0.9.1/amoxide-aarch64-unknown-linux-gnu.tar.xz"
      sha256 "79d290536c78c958f54de920de0aae4c004d5a4c47a9f4c11d9f5cd312f24f7c"
    end
    if Hardware::CPU.intel?
      url "https://github.com/sassman/amoxide-rs/releases/download/v0.9.1/amoxide-x86_64-unknown-linux-gnu.tar.xz"
      sha256 "ef4d926d035212029937590dcb5640492dba6b2d95cb397a2b32474a5d9dbfae"
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
