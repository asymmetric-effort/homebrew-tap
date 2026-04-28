# Asymmetric Effort Homebrew Tap

Official [Homebrew](https://brew.sh) tap for software published by [Asymmetric Effort](https://github.com/asymmetric-effort).

## Installation

```bash
brew tap asymmetric-effort/tap
```

Once tapped, install any available formula:

```bash
brew install asymmetric-effort/tap/<formula>
```

Or install a cask:

```bash
brew install --cask asymmetric-effort/tap/<cask>
```

## Available Formulas

| Formula | Description | Version |
|---------|-------------|---------|
| *(coming soon)* | | |

## Available Casks

| Cask | Description | Version |
|------|-------------|---------|
| *(coming soon)* | | |

## Repository Structure

```
homebrew-tap/
  Formula/        # Homebrew formula definitions (.rb)
  Casks/          # Homebrew cask definitions (.rb)
  cmd/            # Custom brew subcommands
  .github/        # CI workflows and issue templates
```

## Adding a New Formula

1. Create a new file in `Formula/<name>.rb` using the template below.
2. Run `brew audit --new --formula Formula/<name>.rb` to validate.
3. Run `brew install --build-from-source Formula/<name>.rb` to test locally.
4. Open a pull request.

### Formula Template

```ruby
class ExampleTool < Formula
  desc "Short description of the tool"
  homepage "https://github.com/asymmetric-effort/example-tool"
  url "https://github.com/asymmetric-effort/example-tool/archive/refs/tags/v1.0.0.tar.gz"
  sha256 "64-char-sha256-hash"
  license "Apache-2.0"

  depends_on "go" => :build  # adjust for your language

  def install
    system "go", "build", *std_go_args(ldflags: "-s -w")
  end

  test do
    assert_match version.to_s, shell_output("#{bin}/example-tool --version")
  end
end
```

## Adding a New Cask

1. Create a new file in `Casks/<name>.rb`.
2. Run `brew audit --new --cask Casks/<name>.rb` to validate.
3. Run `brew install --cask Casks/<name>.rb` to test locally.
4. Open a pull request.

### Cask Template

```ruby
cask "example-app" do
  version "1.0.0"
  sha256 "64-char-sha256-hash"

  url "https://github.com/asymmetric-effort/example-app/releases/download/v#{version}/example-app-#{version}.dmg"
  name "Example App"
  desc "Short description of the application"
  homepage "https://github.com/asymmetric-effort/example-app"

  app "Example App.app"
end
```

## Updating a Formula

When a new version of a tool is released:

1. Update `url` to point to the new release tarball.
2. Update `sha256` — generate it with `shasum -a 256 <tarball>`.
3. Update `version` if not inferred from the URL.
4. Run `brew audit --formula Formula/<name>.rb`.
5. Open a pull request.

## Contributing

See [CONTRIBUTING.md](CONTRIBUTING.md) for guidelines.

## License

This tap is licensed under the [Apache License 2.0](LICENSE).
Individual formulas install software under their own respective licenses.
