class Leakdetector < Formula
  desc "Secret detection for git repositories"
  homepage "https://leakdetector.asymmetric-effort.com"
  license "MIT"
  version "0.0.13"

  on_macos do
    if Hardware::CPU.arm?
      url "https://github.com/asymmetric-effort/leakdetector/releases/download/v0.0.13/leakdetector_darwin_arm64.tar.gz"
      sha256 "f920f59c729ad660e5e2bff7ff63b86a456c5a2e1f5e37e4726a6541d6c369dd"
    else
      url "https://github.com/asymmetric-effort/leakdetector/releases/download/v0.0.13/leakdetector_darwin_amd64.tar.gz"
      sha256 "8a1655ca6b3c01261da9c28060d92ffd418b83a403be8c545dbbec095fc821f0"
    end
  end

  on_linux do
    if Hardware::CPU.arm?
      url "https://github.com/asymmetric-effort/leakdetector/releases/download/v0.0.13/leakdetector_linux_arm64.tar.gz"
      sha256 "8fbc40213b466b4b117549a6313ca34a52a2aafb9367d3547c6b07f90527d739"
    else
      url "https://github.com/asymmetric-effort/leakdetector/releases/download/v0.0.13/leakdetector_linux_amd64.tar.gz"
      sha256 "e369df067f755fbd7ead9a88b16345357500d0a72a5e052d3d2d5448cae8a59c"
    end
  end

  def install
    bin.install "leakdetector"
  end

  test do
    assert_match version.to_s, shell_output("#{bin}/leakdetector --version")
  end
end
