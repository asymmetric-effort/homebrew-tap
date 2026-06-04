class Leakdetector < Formula
  desc "Secret detection for git repositories"
  homepage "https://leakdetector.asymmetric-effort.com"
  license "MIT"
  version "0.0.14"

  on_macos do
    if Hardware::CPU.arm?
      url "https://github.com/asymmetric-effort/leakdetector/releases/download/v0.0.14/leakdetector_darwin_arm64.tar.gz"
      sha256 "3d8359c50a6b70b7193c1fc471ecae89be5c2c8d1c23ebc693b1bf78269a64c7"
    else
      url "https://github.com/asymmetric-effort/leakdetector/releases/download/v0.0.14/leakdetector_darwin_amd64.tar.gz"
      sha256 "0b2ff37e86861e3905526ed69d82742ff01570498e59c8fae79bd4799f1833b7"
    end
  end

  on_linux do
    if Hardware::CPU.arm?
      url "https://github.com/asymmetric-effort/leakdetector/releases/download/v0.0.14/leakdetector_linux_arm64.tar.gz"
      sha256 "d5e2fdab531fcbb29ba95f864d80cbe4a23ad1ccacf61807754f787b3cf034ef"
    else
      url "https://github.com/asymmetric-effort/leakdetector/releases/download/v0.0.14/leakdetector_linux_amd64.tar.gz"
      sha256 "5adbba31960c5bacca023df5ce9bcf9ce236d79e913f7ebd8d6b1fc21badc469"
    end
  end

  def install
    bin.install "leakdetector"
  end

  test do
    assert_match version.to_s, shell_output("#{bin}/leakdetector --version")
  end
end
