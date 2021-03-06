#!/bin/bash

SCRIPT_DIR="$(cd "$(dirname "$0")" && pwd)"

if [ ! -f "${SCRIPT_DIR}/oauth_token" ]; then
    echo "File '${SCRIPT_DIR}/oauth_token' not found."
    exit 1
fi

OAUTH_TOKEN=$(cat "${SCRIPT_DIR}/oauth_token" | head -n 1)

ISSUE_ID=$1

if [ -z "${ISSUE_ID}" ]; then
    echo "Issue ID is undefined.";
    exit 1;
fi

STARTREK_RESPONSE=$(curl -s -H "Authorization: OAuth ${OAUTH_TOKEN}" \
                         "https://st-api.yandex-team.ru/v2/issues/$ISSUE_ID?pretty=1&fields=key,summary")

function get_property {
    RESPONSE=$1
    PROPERTY_NAME=$2
    echo "${RESPONSE}" \
        | grep ${PROPERTY_NAME} \
        | sed -r 's/\\\"/'\''/g' \
        | sed -rn 's/[^\"]+\"[^\"]+\"[^\"]+\"([^\"]+)\".*/\1/p'
}

ISSUE_SUMMARY=`get_property "${STARTREK_RESPONSE}" "summary"`
KEY=`get_property "${STARTREK_RESPONSE}" "key"`

if [ -z "$ISSUE_SUMMARY" ]; then
    echo "Can not find issue='${ISSUE_ID}'."
    exit 1
fi

BRANCH_NAME=$(git rev-parse --abbrev-ref HEAD)

git config branch."${BRANCH_NAME}".issueid "${KEY}"
git config branch."${BRANCH_NAME}".issuesummary "${ISSUE_SUMMARY}"

echo "Save issue id and description: ${KEY} ${ISSUE_SUMMARY}."
