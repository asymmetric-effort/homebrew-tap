class Leakdetector < Formula
  desc "Secret detection for git repositories"
  homepage "https://leakdetector.asymmetric-effort.com"
  license "MIT"
  version "0.0.15"

  on_macos do
    if Hardware::CPU.arm?
      url "https://github.com/asymmetric-effort/leakdetector/releases/download/v0.0.15/leakdetector_darwin_arm64.tar.gz"
      sha256 "d7b8401d422447b655b36ac123e84fd84014d6bb27352dee2f2f944c7cb37c69"
    else
      url "https://github.com/asymmetric-effort/leakdetector/releases/download/v0.0.15/leakdetector_darwin_amd64.tar.gz"
      sha256 "9c892dffdd9af23be299346f12e974c6de0edecd0e23a894522787f190762797"
    end
  end

  on_linux do
    if Hardware::CPU.arm?
      url "https://github.com/asymmetric-effort/leakdetector/releases/download/v0.0.15/leakdetector_linux_arm64.tar.gz"
      sha256 "f3dff244df003058c09b4a1206b4e672bfb0feec92e1e3df85c063fd94a1f3fd"
    else
      url "https://github.com/asymmetric-effort/leakdetector/releases/download/v0.0.15/leakdetector_linux_amd64.tar.gz"
      sha256 "d194af9e15355f3a2c045db785c72b9430cfe7fa0fbf53542e4fff5410499034"
    end
  end

  def install
    bin.install "leakdetector"
  end

  test do
    assert_match version.to_s, shell_output("#{bin}/leakdetector --version")
  end
end
