#!/bin/sh

cd "$GITHUB_WORKSPACE" || exit 

export REVIEWDOG_GITHUB_API_TOKEN="${INPUT_GITHUB_TOKEN}"

ansible-lint -p ${INPUT_ANSIBLELINT_FLAGS}\
  | reviewdog -efm="%f:%l:%c: %m" \
      -name="ansible-lint" \
      -reporter="${INPUT_REPORTER:-github-pr-check}" \
      -level="${INPUT_LEVEL}" \
      -filter-mode="${INPUT_FILTER_MODE}" \
      -fail-on-error="${INPUT_FAIL_ON_ERROR}" \
      ${INPUT_REVIEWDOG_FLAGS}
