class SsdBenchmark < Formula
  desc "Super Simple Disk Benchmark - benchmarks the writing performance of your disk."
  homepage "https://github.com/sassman/ssd-benchmark-rs"
  version "1.2.4"
  if OS.mac?
    if Hardware::CPU.arm?
      url "https://github.com/sassman/ssd-benchmark-rs/releases/download/v1.2.4/ssd-benchmark-aarch64-apple-darwin.tar.xz"
      sha256 "8622e066fbf877b9421d0547f9f48667d800137866378e86e72e3bc9b3b37751"
    end
    if Hardware::CPU.intel?
      url "https://github.com/sassman/ssd-benchmark-rs/releases/download/v1.2.4/ssd-benchmark-x86_64-apple-darwin.tar.xz"
      sha256 "6d65dd38334f7ce31b16b29305da51b8057a06e8b3e5b258ee6aaa80b9ee2522"
    end
  end
  if OS.linux?
    if Hardware::CPU.arm?
      url "https://github.com/sassman/ssd-benchmark-rs/releases/download/v1.2.4/ssd-benchmark-aarch64-unknown-linux-musl.tar.xz"
      sha256 "03ff2879539621ad9e883ea4d80df6ed0d388c30f8accf82839366df1e808bab"
    end
    if Hardware::CPU.intel?
      url "https://github.com/sassman/ssd-benchmark-rs/releases/download/v1.2.4/ssd-benchmark-x86_64-unknown-linux-musl.tar.xz"
      sha256 "4a10bb11f1390fe97c34e2e2b91c594bfeb89572d2fad5ce1ef9bcfc0cad8117"
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
    bin.install "ssd-benchmark" if OS.mac? && Hardware::CPU.arm?
    bin.install "ssd-benchmark" if OS.mac? && Hardware::CPU.intel?
    bin.install "ssd-benchmark" if OS.linux? && Hardware::CPU.arm?
    bin.install "ssd-benchmark" if OS.linux? && Hardware::CPU.intel?

    install_binary_aliases!

    # Homebrew will automatically install these, so we don't need to do that
    doc_files = Dir["README.*", "readme.*", "LICENSE", "LICENSE.*", "CHANGELOG.*"]
    leftover_contents = Dir["*"] - doc_files

    # Install any leftover files in pkgshare; these are probably config or
    # sample files.
    pkgshare.install(*leftover_contents) unless leftover_contents.empty?
  end
end
