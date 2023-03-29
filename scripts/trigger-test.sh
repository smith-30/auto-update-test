#!/usr/bin/env bash

set -e
set -o nounset

SCRIPT_DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" >/dev/null 2>&1 && pwd )"

pushd "${SCRIPT_DIR}/.." > /dev/null

TRIGGER_FILE="./AUTOUPDATE_TRIGGER"
# Read current trigger number and trim whitespace
TRIGGER_COUNT=$(tr -d '\040\011\012\015' < "${TRIGGER_FILE}")

echo -e "Current trigger number: ${TRIGGER_COUNT}"
TRIGGER_COUNT=$((TRIGGER_COUNT+1))

echo -e "Incrementing trigger number to: ${TRIGGER_COUNT}"

echo -e "Committing and pushing result to trigger an autoupdate"

echo "${TRIGGER_COUNT}" > "${TRIGGER_FILE}"
git add "${TRIGGER_FILE}"
git commit -m "Trigger autoupdate (attempt ${TRIGGER_COUNT})"
git push
