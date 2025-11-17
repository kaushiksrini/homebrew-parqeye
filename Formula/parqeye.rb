class Parqeye < Formula
  desc "Parquet viewer for the command line"
  homepage "https://github.com/kaushiksrini/parqeye"
  version "0.0.2"
  if OS.mac?
    if Hardware::CPU.arm?
      url "https://github.com/kaushiksrini/parqeye/releases/download/v0.0.2/parqeye-aarch64-apple-darwin.tar.xz"
      sha256 "1995b59f06b5720c46beb2bcdada08c7c568bf0d01b182d7a1e50c7fdc305b9a"
    end
    if Hardware::CPU.intel?
      url "https://github.com/kaushiksrini/parqeye/releases/download/v0.0.2/parqeye-x86_64-apple-darwin.tar.xz"
      sha256 "a9ee1aa6bc0d773d7d3edf8335637411a04412b506dbe081f78990d970c76036"
    end
  end
  if OS.linux?
    if Hardware::CPU.arm?
      url "https://github.com/kaushiksrini/parqeye/releases/download/v0.0.2/parqeye-aarch64-unknown-linux-gnu.tar.xz"
      sha256 "a8ae74222514bb8ae61fa58065cc59f5b82b7b31fbc57433ef2ef88b3a085dc1"
    end
    if Hardware::CPU.intel?
      url "https://github.com/kaushiksrini/parqeye/releases/download/v0.0.2/parqeye-x86_64-unknown-linux-gnu.tar.xz"
      sha256 "68d03738b0bbe6c70e45008cffd7f1bda194dad921c97359de87b2ab43f51fc3"
    end
  end
  license "MIT"

  BINARY_ALIASES = {
    "aarch64-apple-darwin":              {},
    "aarch64-unknown-linux-gnu":         {},
    "x86_64-apple-darwin":               {},
    "x86_64-pc-windows-gnu":             {},
    "x86_64-unknown-linux-gnu":          {},
    "x86_64-unknown-linux-musl-dynamic": {},
    "x86_64-unknown-linux-musl-static":  {},
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
    bin.install "parqeye" if OS.mac? && Hardware::CPU.arm?
    bin.install "parqeye" if OS.mac? && Hardware::CPU.intel?
    bin.install "parqeye" if OS.linux? && Hardware::CPU.arm?
    bin.install "parqeye" if OS.linux? && Hardware::CPU.intel?

    install_binary_aliases!

    # Homebrew will automatically install these, so we don't need to do that
    doc_files = Dir["README.*", "readme.*", "LICENSE", "LICENSE.*", "CHANGELOG.*"]
    leftover_contents = Dir["*"] - doc_files

    # Install any leftover files in pkgshare; these are probably config or
    # sample files.
    pkgshare.install(*leftover_contents) unless leftover_contents.empty?
  end
end
