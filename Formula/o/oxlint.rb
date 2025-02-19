class Oxlint < Formula
  desc "Suite of high-performance tools for JavaScript and TypeScript written in Rust"
  homepage "https://oxc.rs/"
  url "https://github.com/oxc-project/oxc/archive/refs/tags/oxlint_v0.9.9.tar.gz"
  sha256 "75f8c87eadae6260469dd4bcc8ce5c7ae9cffcff77c2c477d2fc09ac0a351666"
  license "MIT"
  head "https://github.com/oxc-project/oxc.git", branch: "main"

  livecheck do
    url :stable
    regex(/^oxlint[._-]v?(\d+(?:\.\d+)+)$/i)
  end

  bottle do
    sha256 cellar: :any_skip_relocation, arm64_sequoia: "896ddebbafb4ea8fe10d0abdca4bc6ce213436c562781c46dde80e198a914d51"
    sha256 cellar: :any_skip_relocation, arm64_sonoma:  "2e5ba19d9aedc836f71eaf3131f6e9ccad447eec8c4a5090ad2508d2b7d3ff47"
    sha256 cellar: :any_skip_relocation, arm64_ventura: "f890d60aa92157b0818599ac3a820b854ec91641605b0e2ec6d32ad1a18d55f8"
    sha256 cellar: :any_skip_relocation, sonoma:        "4cab00c657a56e0413e1e03daeff434c084c9fbed61731cc095baf172378cef4"
    sha256 cellar: :any_skip_relocation, ventura:       "3c9ed3ae276dcb5946b71861188aa921256ada4c9adc1a3ecfe91aa6a755778a"
    sha256 cellar: :any_skip_relocation, x86_64_linux:  "4ff41507cae30c61f179231e07630f2a0622a3bc6d397e3cd1755b4f12bc6aa9"
  end

  depends_on "rust" => :build

  def install
    ENV["OXC_VERSION"] = version.to_s
    system "cargo", "install", *std_cargo_args(path: "apps/oxlint")
  end

  test do
    (testpath/"test.js").write "const x = 1;"
    output = shell_output("#{bin}/oxlint test.js 2>&1")
    assert_match "eslint(no-unused-vars): Variable 'x' is declared but never used", output

    assert_match version.to_s, shell_output("#{bin}/oxlint --version")
  end
end
