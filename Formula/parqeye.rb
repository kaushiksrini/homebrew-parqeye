class Parqeye < Formula
  desc "Parquet viewer for the command line"
  homepage "https://github.com/kaushiksrini/parqeye"
  version "0.2.0"
  if OS.mac?
    if Hardware::CPU.arm?
      url "https://github.com/kaushiksrini/parqeye/releases/download/v0.2.0/parqeye-aarch64-apple-darwin.tar.xz"
      sha256 "728905b69b6e05a27b73e7c8655f01f12f3130510afecea9dc6236597d325cd2"
    end
    if Hardware::CPU.intel?
      url "https://github.com/kaushiksrini/parqeye/releases/download/v0.2.0/parqeye-x86_64-apple-darwin.tar.xz"
      sha256 "e2f1f312109253565ba2451be051e72ce700caf2f19159380befd16b1c629b2e"
    end
  end
  if OS.linux?
    if Hardware::CPU.arm?
      url "https://github.com/kaushiksrini/parqeye/releases/download/v0.2.0/parqeye-aarch64-unknown-linux-gnu.tar.xz"
      sha256 "6e9eb7703697f19b84ab5d66136f0dce2a1c4bb0b374e2b0ea7f1b65d47e9727"
    end
    if Hardware::CPU.intel?
      url "https://github.com/kaushiksrini/parqeye/releases/download/v0.2.0/parqeye-x86_64-unknown-linux-gnu.tar.xz"
      sha256 "7f9b444665132b827e904fc360455209f37da27417dffcbf7b0741285bd53e24"
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
    if OS.mac? && Hardware::CPU.arm?
      bin.install "parqeye"
    end
    if OS.mac? && Hardware::CPU.intel?
      bin.install "parqeye"
    end
    if OS.linux? && Hardware::CPU.arm?
      bin.install "parqeye"
    end
    if OS.linux? && Hardware::CPU.intel?
      bin.install "parqeye"
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
