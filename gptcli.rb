class Gptcli < Formula
  desc "A CLI tool for generating content with GPT"
  homepage "https://github.com/mohramadan911/gptcli"
  url "https://github.com/mohramadan911/gptcli/archive/refs/tags/v1.0.0.tar.gz" 
  sha256 "2e07b3e198e5ecb0074ebc4276057674fe47c42c1bcb20f200bc80efe85f8a6d"

  def install
    bin.install "gptcli"
  end
end
