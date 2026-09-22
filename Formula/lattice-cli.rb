# Source-build formula: the upstream repo is private, so prebuilt release
# assets cannot be fetched from a public tap. Homebrew clones over HTTPS
# using the gh credential helper. The release workflow rewrites tag and
# revision on every release.
class LatticeCli < Formula
  desc "Agent-first CLI for pulling feedback out of Lattice"
  homepage "https://github.com/tammersaleh/lattice-cli"
  url "https://github.com/tammersaleh/lattice-cli.git", tag: "v1.0.0", revision: "bcbb0434ecbaaa05aceaf8d629743ecdfae1a4e0"
  license "MIT"

  depends_on "go" => :build

  def install
    system "go", "build", "-trimpath",
      "-ldflags", "-s -w -X github.com/tammersaleh/lattice-cli/cmd.Version=#{version}",
      "-o", bin/"lattice", "./cmd/lattice"
  end

  test do
    assert_match version.to_s, shell_output("#{bin}/lattice version")
  end
end
