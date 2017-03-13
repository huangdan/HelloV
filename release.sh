#! /bin/bash

set -e

TAGS=(emqttd emq-modules emq-dashboard emq-retainer emq-recon emq-reloader emq-auth-clientid emq-auth-username emq-auth-ldap emq-auth-http emq-auth-mysql emq-auth-pgsql emq-auth-redis emq-auth-mongo)

#TAGS=(HelloV)
TEMP_GITHUB_REPO=tmp_tags
GITHUB_USER=emqtt
mkdir $TEMP_GITHUB_REPO
for tag in ${TAGS[@]} ; do \
    cd /Users/huangdan/testTools/HelloV
    GIT_REPO="git@github.com:"${GITHUB_USER}"/"${tag}".git"
    echo $GIT_REPO
    echo $1
    git clone --progress $GIT_REPO $TEMP_GITHUB_REPO/$tag || { echo "Unable to clone repo."; exit 1; }; \
    cd $TEMP_GITHUB_REPO/$tag; \
    # Check if version is already released.
    if git show-ref --tags | egrep -q "refs/tags/$1"
    then
    echo "Version already tagged and released.";
    echo ""
    echo "Run sh release.sh again and enter another version.";
    exit 1;
    else
    echo ""
    echo "$1 has not been found released.";
    fi
    git tag -a "$1" -m "$2"; \
    git push origin $1; \
done

#read -p "Enter your GitHub username: " GITHUB_USER
#clear
#
#read -p "Now enter the repository slug: " GITHUB_REPO_NAME
#clear

# REMOVE THE TEMP DIRS
echo "Cleaning Up..."
cd "../.."
rm -rf $TEMP_GITHUB_REPO
#clear
