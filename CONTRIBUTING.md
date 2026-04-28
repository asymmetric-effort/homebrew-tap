# Contributing to homebrew-tap

Thank you for contributing to the Asymmetric Effort Homebrew tap.

## Requirements

- macOS with [Homebrew](https://brew.sh) installed
- Familiarity with [Homebrew formula authoring](https://docs.brew.sh/Formula-Cookbook)

## Submitting a New Formula

1. Fork this repository.
2. Create a branch: `git checkout -b add-<formula-name>`.
3. Add your formula file to `Formula/<name>.rb`.
4. Validate locally:
   ```bash
   brew audit --new --formula Formula/<name>.rb
   brew install --build-from-source Formula/<name>.rb
   brew test Formula/<name>.rb
   ```
5. Open a pull request with:
   - A description of the software being packaged.
   - Confirmation that audit, install, and test passed.

## Submitting a New Cask

1. Fork this repository.
2. Create a branch: `git checkout -b add-cask-<name>`.
3. Add your cask file to `Casks/<name>.rb`.
4. Validate locally:
   ```bash
   brew audit --new --cask Casks/<name>.rb
   brew install --cask Casks/<name>.rb
   ```
5. Open a pull request.

## Updating an Existing Formula or Cask

1. Create a branch: `git checkout -b update-<name>-<version>`.
2. Update the `url`, `sha256`, and `version` as needed.
3. Run audit and install tests.
4. Open a pull request noting the version change.

## Style Guidelines

- Follow the [Homebrew Formula Cookbook](https://docs.brew.sh/Formula-Cookbook) conventions.
- Use `snake_case` for formula file names.
- Include a `test` block in every formula.
- Keep descriptions concise (under 80 characters).

## Code of Conduct

Be respectful and constructive. We follow the [Contributor Covenant](https://www.contributor-covenant.org/version/2/1/code_of_conduct/).
