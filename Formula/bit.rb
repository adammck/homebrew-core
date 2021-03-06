require "language/node"

class Bit < Formula
  desc "Distributed Code Component Manager"
  homepage "https://bit.dev"
  url "https://registry.npmjs.org/bit-bin/-/bit-bin-14.8.2.tgz"
  sha256 "356b42e8fb4ba98904c6c6a108368f022ffd0860b8024f073b97c70585dab904"
  head "https://github.com/teambit/bit.git"

  bottle do
    sha256 "fa499ed46cc454d56cce71bacefbdbb98f5eecc5ea97aac52a12686a4ff4ba9c" => :catalina
    sha256 "f4205815482f02f97472d9cdbd828d3b74fa05bdb19285b55b7089578b2122dd" => :mojave
    sha256 "b01650432eb5858992d8cd78e46da2a49ec7c530157aa0bfe44beebf08f8a204" => :high_sierra
  end

  depends_on "node"

  def install
    system "npm", "install", *Language::Node.std_npm_install_args(libexec)
    bin.install_symlink Dir["#{libexec}/bin/*"]
  end

  test do
    (testpath/"Library/Caches/Bit/config/config.json").write <<~EOS
      { "analytics_reporting": false, "error_reporting": false }
    EOS
    output = shell_output("#{bin}/bit init --skip-update")
    assert_match "successfully initialized", output
  end
end
