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

## Available Formulas

| Formula | Description |
|---------|-------------|
| [leakdetector](https://leakdetector.asymmetric-effort.com) | Secret detection for git repositories |

## Quick Start

```bash
brew tap asymmetric-effort/tap
brew install leakdetector
leakdetector --version
```

## Repository Structure

```
homebrew-tap/
  Formula/                   # Homebrew formula definitions (.rb)
  Casks/                     # Homebrew cask definitions (.rb)
  cmd/                       # Custom brew subcommands
  formula-sources.json       # Automated formula publishing registry
  .github/
    workflows/
      audit.yml              # Validates formulas on PR
      publish-formulas.yml   # Polls for new releases, generates formulas
```

## Automated Formula Publishing

Formulas are generated automatically. A daily workflow polls registered
projects for new GitHub Releases and generates Homebrew formulas from the
release tarballs.

### How It Works

1. Projects are registered in `formula-sources.json`.
2. The `publish-formulas.yml` workflow runs daily at 06:00 UTC (and on
   manual trigger).
3. For each registered project, the workflow checks for a new GitHub Release.
4. If a new version is found, it downloads the release tarballs, computes
   SHA256 hashes, generates a formula, and opens a pull request.
5. The `audit.yml` workflow validates the formula via `brew audit`.
6. If the audit passes, the PR is auto-merged.

No secrets or cross-repo tokens are required. The workflow reads public
GitHub Release APIs and uses its own `GITHUB_TOKEN` for write operations
within this repository.

### Version Immutability

Versions are immutable. If a formula already exists at a given version,
the workflow skips it. Publishing a new release with a previously used
version tag will not overwrite the existing formula.

### Adding a New Project

To register a new project for automated formula publishing, add an entry
to `formula-sources.json`:

```json
[
  {
    "project": "leakdetector",
    "repo": "asymmetric-effort/leakdetector",
    "description": "Secret detection for git repositories",
    "homepage": "https://leakdetector.asymmetric-effort.com",
    "license": "MIT",
    "test_flag": "--version"
  },
  {
    "project": "your-tool",
    "repo": "asymmetric-effort/your-tool",
    "description": "Short description of the tool",
    "homepage": "https://your-tool.asymmetric-effort.com",
    "license": "MIT",
    "test_flag": "--version"
  }
]
```

#### Registry Fields

| Field | Required | Default | Description |
|-------|----------|---------|-------------|
| `project` | yes | | Formula name and binary name |
| `repo` | yes | | GitHub `owner/repo` for the project |
| `description` | yes | | One-line description for `brew info` |
| `homepage` | yes | | Project homepage URL |
| `license` | no | `MIT` | SPDX license identifier |
| `test_flag` | no | `--version` | CLI flag used in `brew test` |

### Release Asset Requirements

The project's GitHub Release must include tarballs with this naming
convention:

```
{project}_{os}_{arch}.tar.gz
```

Required assets for each release:

| Asset | Platform |
|-------|----------|
| `{project}_darwin_amd64.tar.gz` | macOS Intel |
| `{project}_darwin_arm64.tar.gz` | macOS Apple Silicon |
| `{project}_linux_amd64.tar.gz` | Linux x86_64 |
| `{project}_linux_arm64.tar.gz` | Linux ARM64 |

Each tarball must contain the binary at the top level (not nested in
subdirectories).

### Example: Setting Up a New Project

**1. Add a release workflow to your project** (e.g., `.github/workflows/release.yml`):

```yaml
name: Release

on:
  push:
    tags:
      - "v*"

permissions:
  contents: write

jobs:
  release:
    runs-on: ubuntu-latest
    steps:
      - uses: actions/checkout@v4

      - uses: actions/setup-go@v5
        with:
          go-version: "1.26"

      - name: Build
        run: make build

      - name: Create tarballs
        run: |
          VERSION="${GITHUB_REF_NAME#v}"
          mkdir -p dist
          for os in linux darwin; do
            for arch in amd64 arm64; do
              tar -czf "dist/myproject_${os}_${arch}.tar.gz" \
                -C "build/${os}/${arch}" myproject
            done
          done

      - name: Publish release
        env:
          GH_TOKEN: ${{ secrets.GITHUB_TOKEN }}
        run: |
          gh release create "$GITHUB_REF_NAME" \
            --title "myproject ${GITHUB_REF_NAME#v}" \
            --generate-notes \
            dist/myproject_*.tar.gz
```

**2. Add your project to `formula-sources.json`** in this repository:

```json
{
  "project": "myproject",
  "repo": "asymmetric-effort/myproject",
  "description": "What the tool does",
  "homepage": "https://myproject.asymmetric-effort.com",
  "license": "MIT",
  "test_flag": "--version"
}
```

**3. Tag a release** in your project:

```bash
git tag v1.0.0
git push origin v1.0.0
```

**4. Wait for the formula to be published.** The workflow runs daily, or
trigger it manually from the Actions tab. A PR will be opened, audited,
and auto-merged.

**5. Users can install:**

```bash
brew tap asymmetric-effort/tap
brew install myproject
```

### Manual Trigger

To publish formulas immediately without waiting for the daily schedule:

1. Go to **Actions** > **Publish Formulas** in this repository.
2. Click **Run workflow**.

## Manual Formula Management

### Adding a Formula Manually

If a project doesn't use the automated publishing system:

1. Create a new file in `Formula/<name>.rb`.
2. Run `brew audit --new --formula Formula/<name>.rb` to validate.
3. Run `brew install --build-from-source Formula/<name>.rb` to test locally.
4. Open a pull request.

### Formula Template

```ruby
class ExampleTool < Formula
  desc "Short description of the tool"
  homepage "https://github.com/asymmetric-effort/example-tool"
  license "MIT"
  version "1.0.0"

  on_macos do
    if Hardware::CPU.arm?
      url "https://github.com/asymmetric-effort/example-tool/releases/download/v1.0.0/example-tool_darwin_arm64.tar.gz"
      sha256 "64-char-sha256-hash"
    else
      url "https://github.com/asymmetric-effort/example-tool/releases/download/v1.0.0/example-tool_darwin_amd64.tar.gz"
      sha256 "64-char-sha256-hash"
    end
  end

  on_linux do
    if Hardware::CPU.arm?
      url "https://github.com/asymmetric-effort/example-tool/releases/download/v1.0.0/example-tool_linux_arm64.tar.gz"
      sha256 "64-char-sha256-hash"
    else
      url "https://github.com/asymmetric-effort/example-tool/releases/download/v1.0.0/example-tool_linux_amd64.tar.gz"
      sha256 "64-char-sha256-hash"
    end
  end

  def install
    bin.install "example-tool"
  end

  test do
    assert_match version.to_s, shell_output("#{bin}/example-tool --version")
  end
end
```

### Updating a Formula Manually

1. Update `url`, `sha256`, and `version` fields.
2. Run `brew audit --formula Formula/<name>.rb`.
3. Open a pull request.

## Contributing

See [CONTRIBUTING.md](CONTRIBUTING.md) for guidelines.

## License

This tap is licensed under the [Apache License 2.0](LICENSE).
Individual formulas install software under their own respective licenses.
