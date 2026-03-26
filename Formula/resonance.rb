class Resonance < Formula
  desc "Privacy-preserving decentralized matching protocol"
  homepage "https://github.com/Planetary-e/resonance"
  version "0.1.1"
  license "MIT"

  on_macos do
    on_arm do
      url "https://github.com/Planetary-e/resonance/releases/download/v0.1.1/resonance-macos-arm64.tar.gz"
      sha256 ""
    end
  end

  on_linux do
    on_intel do
      url "https://github.com/Planetary-e/resonance/releases/download/v0.1.1/resonance-linux-x64.tar.gz"
      sha256 "c976b2629394c8c22af27e15629db5f8b8baffa28882e6e5faad35a37c5b973e"
    end
  end

  def install
    if OS.mac?
      bin.install "resonance-macos-arm64" => "resonance"
    elsif OS.linux?
      bin.install "resonance-linux-x64" => "resonance"
    end

    # Install UI files alongside the binary
    (libexec/"ui").install Dir["ui/*"] if (buildpath/"ui").exist?

    # Install native modules if present
    lib.install Dir["*.node"]
  end

  def caveats
    <<~EOS
      Resonance runs a local web server on http://localhost:3000
      
      To start: resonance
      Your browser will open automatically.
      
      On first run, the embedding model (~90MB) will be downloaded.
    EOS
  end

  test do
    assert_match "Resonance", shell_output("#{bin}/resonance --help 2>&1", 0)
  end
end
