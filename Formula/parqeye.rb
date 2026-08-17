class Parqeye < Formula
  desc "Parquet viewer for the command line"
  homepage "https://github.com/kaushiksrini/parqeye"
  version "0.1.0"
  if OS.mac?
    if Hardware::CPU.arm?
      url "https://github.com/kaushiksrini/parqeye/releases/download/v0.1.0/parqeye-aarch64-apple-darwin.tar.xz"
      sha256 "f8f2f41c50ef29f7e9002335a0390d214617a934a9030fc617f02203be4754d8"
    end
    if Hardware::CPU.intel?
      url "https://github.com/kaushiksrini/parqeye/releases/download/v0.1.0/parqeye-x86_64-apple-darwin.tar.xz"
      sha256 "3cff6deee228f66478c6d257fc3bc2143c44ca2dada495db62011b5c8841c727"
    end
  end
  if OS.linux?
    if Hardware::CPU.arm?
      url "https://github.com/kaushiksrini/parqeye/releases/download/v0.1.0/parqeye-aarch64-unknown-linux-gnu.tar.xz"
      sha256 "b01487e1117ee65fad779007b91c2a7d31028304bdf96b48ebdeaea4339329fc"
    end
    if Hardware::CPU.intel?
      url "https://github.com/kaushiksrini/parqeye/releases/download/v0.1.0/parqeye-x86_64-unknown-linux-gnu.tar.xz"
      sha256 "fdc2cf96e1b975b05bc9b0c208b47de13dd1cbc14cb2e1f11de4e379d8e2426b"
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
