class AmoxideTui < Formula
  desc "Interactive TUI for amoxide — manage aliases and profiles visually"
  homepage "https://github.com/sassman/amoxide-rs"
  version "0.4.0"
  if OS.mac?
    if Hardware::CPU.arm?
      url "https://github.com/sassman/amoxide-rs/releases/download/v0.4.0/amoxide-tui-aarch64-apple-darwin.tar.xz"
      sha256 "c15eff902da01fb6a0d69c5d3d30ed817d174fb45882c515152caeca339d5ca9"
    end
    if Hardware::CPU.intel?
      url "https://github.com/sassman/amoxide-rs/releases/download/v0.4.0/amoxide-tui-x86_64-apple-darwin.tar.xz"
      sha256 "61bbf60fcfd4eec4e2228156b87d8d60f686b7d9e50e465c60e3e2d70b73944d"
    end
  end
  if OS.linux?
    if Hardware::CPU.arm?
      url "https://github.com/sassman/amoxide-rs/releases/download/v0.4.0/amoxide-tui-aarch64-unknown-linux-gnu.tar.xz"
      sha256 "09039d203a6ef1597955507d61a3dbb5bca84d5def139c1a651f32dd96393bb0"
    end
    if Hardware::CPU.intel?
      url "https://github.com/sassman/amoxide-rs/releases/download/v0.4.0/amoxide-tui-x86_64-unknown-linux-gnu.tar.xz"
      sha256 "7bafa05c01154683cfea68eb1918ac1b25f693b86a366b96f00c016646b35880"
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
