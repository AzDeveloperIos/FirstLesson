#! /bin/bash

token=$1
owner="AzDeveloperIos"
repo="FirstLesson"
tag_name="latest"
commit_sha=$(git log -n1 --format=format:"%H")
current_branch=$(git rev-parse --abbrev-ref HEAD)

command="curl -i \
--request POST \
-u username:$token \
--data '{\"ref\": \"refs/tags/$tag_name\",\"sha\": \"$commit_sha\"}' \
https://api.github.com/repos/$owner/$repo/git/refs"

git tag $tag_name
eval "$command"
