# GitHub Action: Run ansible-lint with reviewdog 🐕

[![Docker Image CI](https://github.com/reviewdog/action-ansiblelint/workflows/Docker%20Image%20CI/badge.svg?branch=master)](https://github.com/reviewdog/action-ansiblelint/actions)
[![Release](https://img.shields.io/github/v/release/reviewdog/action-ansiblelint?logoColor=orange)](https://github.com/reviewdog/action-ansiblelint/releases)


This action runs [ansible-lint](https://github.com/ansible/ansible-lint) with
[reviewdog](https://github.com/reviewdog/reviewdog) on pull requests to improve
code review experience.

[![github-pr-check sample](https://user-images.githubusercontent.com/20274882/90307579-67142400-df12-11ea-96e9-62710cb1fff0.png)](https://github.com/reviewdog/action-ansiblelint/pull/1)
[![github-pr-review sample](https://user-images.githubusercontent.com/20274882/90307608-c70aca80-df12-11ea-9556-921f1e7e6281.png)](https://github.com/reviewdog/action-ansiblelint/pull/1)

## Inputs

### `github_token`

Optional. `${{ github.token }}` is used by default.

### `level`

Optional. Report level for reviewdog [info,warning,error].
It's same as `-level` flag of reviewdog.

### `reporter`

Reporter of reviewdog command [github-pr-check,github-check,github-pr-review].
Default is github-pr-check.
It's same as `-reporter` flag of reviewdog.

github-pr-review can use Markdown and add a link to rule page in reviewdog reports.

### `filter_mode`

Optional. Filtering mode for the reviewdog command [added,diff_context,file,nofilter]. Default is added.

### `fail_on_error`

Optional. Exit code for reviewdog when errors are found [true,false] Default is `false`.

### `reviewdog_flags`

Optional. Additional reviewdog flags.

### `ansiblellint_flags`

Optional. Flags and args of ansible-lint command.

## Example usage

You can create [ansible-lint config](https://docs.ansible.com/ansible-lint/configuring/configuring.html).

### [.github/workflows/reviewdog.yml](.github/workflows/reviewdog.yml)

```yml
name: reviewdog
on: [pull_request]
jobs:
  ansible-lint:
    name: runner / ansible-lint 
    runs-on: ubuntu-latest
    steps:
      - uses: actions/checkout@v2
      - uses: actions/setup-python@v2
        with:
          python-version: 3.6
      - name: ansible-lint
        uses: reviewdog/action-ansiblelint@v1
        with:
          github_token: ${{ secrets.github_token }}
          reporter: github-pr-review # Change reporter.
          ansiblelint_flags: '-x 301 playbook/*'
```
