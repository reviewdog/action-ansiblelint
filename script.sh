#!/bin/bash

cd "${GITHUB_WORKSPACE}/${INPUT_WORKING_DIRECTORY}" || exit

TEMP_PATH="$(mktemp -d)"
PATH="${TEMP_PATH}:$PATH"

echo '::group::🐶 Installing reviewdog ... https://github.com/reviewdog/reviewdog'
curl -sfL https://raw.githubusercontent.com/reviewdog/reviewdog/master/install.sh | sh -s -- -b "${TEMP_PATH}" "${REVIEWDOG_VERSION}" 2>&1
echo '::endgroup::'

echo '::group:: Installing ansible-lint ... https://github.com/ansible/ansible-lint'
pip3 install --no-cache-dir ansible-lint=="${INPUT_ANSIBLELINT_VERSION}" "ansible>=2.9,<2.11"
echo '::endgroup::'

export REVIEWDOG_GITHUB_API_TOKEN="${INPUT_GITHUB_TOKEN}"

echo '::group:: Running ansible-lint with reviewdog 🐶 ...'
ansible-lint -p ${INPUT_ANSIBLELINT_FLAGS} \
  | reviewdog -efm="%f:%l: %m" \
      -name="ansible-lint" \
      -reporter="${INPUT_REPORTER:-github-pr-check}" \
      -level="${INPUT_LEVEL}" \
      -filter-mode="${INPUT_FILTER_MODE}" \
      -fail-level="${INPUT_FAIL_LEVEL}" \
      -fail-on-error="${INPUT_FAIL_ON_ERROR}" \
      ${INPUT_REVIEWDOG_FLAGS}
exit_code=$?
echo '::endgroup::'

exit $exit_code
