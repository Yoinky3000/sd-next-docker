#!/usr/bin/env bash

cd /workspace/SD\ Next

echo ""

git fetch > /dev/null

currentBranch=$(git branch --show-current)
echo "Current branch: $currentBranch"


if [ -n "$BRANCH" ]; then
    branches=$(git branch -r | awk '{gsub(/^[[:space:]]+|\/[[:space:]]*$/, "", $1); print substr($1, 8)}' | grep -v "HEAD")
    
    if ! echo "$branches" | grep -q "\b$BRANCH\b"; then
        echo "$BRANCH is not a valid branch"
        echo -e "\nHere are all available branches:\n$branches"
        exit
    fi
    
    if [ "$BRANCH" != "$currentBranch" ]; then
        echo "Switching branch to - $BRANCH"
        git checkout "$BRANCH" > /dev/null 2>&1
        echo "Branch is now switched to - $BRANCH"
    fi
fi

BRANCH=${BRANCH:-$currentBranch}

echo ""

currentCommit=$(git rev-parse HEAD)
currentCommitShort=$(echo "$currentCommit" | cut -c -7)
echo "Current commit: $currentCommitShort ($currentCommit)"

if [ -n "$COMMIT" ]; then
    branchOfCommit=$(git branch -a --contains "$COMMIT" | awk '{gsub(/^[[:space:]]+|\/[[:space:]]*$/, "", $1); if (substr($1, 1, 15) == "remotes/origin/") print substr($1, 16); else print substr($1, 3)}' | awk '!/HEAD/')
    
    if ! echo "$branchOfCommit" | grep -q "\b$BRANCH\b"; then
        echo "Commit ($COMMIT) is not under the branch $BRANCH"
        exit
    fi

    currentCommit=$(expr substr "$currentCommit" 1 "${#COMMIT}")
    
    if [ "$COMMIT" != "$currentCommit" ]; then
        echo "Switching commit to ($COMMIT)"
        git reset --hard "$COMMIT" > /dev/null 2>&1
        echo -e "Commit is now switched to ($COMMIT)\n- Info of the commit"
        git log -1 "$COMMIT" | sed "1d"
    else
        echo "Commit not changed"
    fi
else
    echo "- Info of the commit"
    git log -1 "$currentCommit" | sed "1d"
fi