#! /bin/bash

token=$1
owner="AzDeveloperIos"
repo="FirstLesson"
tag_name="latest"
commit_sha=$(git log -n1 --format=format:"%H")

create_tag(){
command="curl -i \
--request POST \
-u username:$token \
--data '{\"ref\": \"refs/tags/$tag_name\",\"sha\": \"$commit_sha\"}' \
https://api.github.com/repos/$owner/$repo/git/refs"

git tag $tag_name
eval "$command"
}

update_tag() {
command="curl -i \
--request PATCH \
-u username:$token \
--data '{\"sha\": \"$commit_sha\", \"force\":true}' \
https://api.github.com/repos/$owner/$repo/git/refs/tags/$tag_name"

eval "$command"
}

if git tag --list | grep -Eq "$tag_name" ; then
    echo "Updating the 'latest' tag"
    update_tag
else
    echo "Creating a 'latest' tag"
    create_tag
fi