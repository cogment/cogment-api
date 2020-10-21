#!/usr/bin/env bash

####
# Github pages release script
####

# Base settings
GH_ORG="cogment"
GH_REPO="cogment-api"
GH_BRANCH="gh-pages"
PUBLISH_AUTHOR_NAME="Artificial Intelligence Redefined"
PUBLISH_AUTHOR_EMAIL="dev+cogment@ai-r.com"
ROOT_PUB_DIR="./publish"
INCLUDE=(
  "./*.proto"
  "./api_version.txt"
  "./README.md"
)
ARTIFACT_BASENAME="cogment-api"

# Utility functions
## join_by "-delimiter-" "a" "b" "c" => "a-delimiter-b-delimiter-c"
function join_by() {
  local delimiter=$1
  shift
  local strings=$1
  shift
  printf %s "$strings" "${@/#/$delimiter}"
}

function usage() {
  local usage_str=""
  usage_str+="Publish a version of cogment-api\n\n"
  usage_str+="The package will be deployed to https://github.com/${GH_ORG}/${GH_REPO}/tree/${GH_BRANCH}\n\n"
  usage_str+="Requirements:\n"
  usage_str+="  A running ssh agent having a read/write key for this repo.\n\n"
  usage_str+="Options:\n"
  usage_str+="  --version <v>:  The version to be published [default: latest].\n"
  usage_str+="  --dry-run:      Skip the actual publishing.\n"
  usage_str+="  -v, --verbose:  Verbose output, shows executed commands.\n"
  usage_str+="  -h, --help:     Show this screen.\n\n"
  printf "%b" "${usage_str}"
}

# Any subsequent(*) commands which fail will cause the shell script to exit immediately
set -o errexit

# I - Parse the commande line arguments.
verbose=0
dry_run=0
version=latest

while [ "$1" != "" ]; do
  case $1 in
    --verbose | -v)
      verbose=1
      ;;
    --dry-run)
      dry_run=1
      ;;
    --help | -h)
      usage
      exit 0
      ;;
    --version)
      shift
      version=$1
      ;;
  esac
  shift
done

## II - Listing all the file we want to publish.
find_cmd="find . -path \"$(join_by "\" -or -path \"" "${INCLUDE[@]}")\""
if [ ${verbose} == 1 ]; then
  printf "Listing files to be released:\n  %s\n\n" "${find_cmd}"
fi
# Values returned by `find` are safe to be split, disabling shellcheck warning
# shellcheck disable=SC2207
included_files=($(eval "${find_cmd}"))

## III - Cloning the repository/branch used for publication
clone_repo_cmd="rm -rf ${ROOT_PUB_DIR};
  git clone -q -b ${GH_BRANCH} git@github.com:${GH_ORG}/${GH_REPO}.git ${ROOT_PUB_DIR}"
if [ ${verbose} == 1 ]; then
  printf "Cloning the repository used for publication:\n  %s\n\n" "${clone_repo_cmd}"
fi
eval "${clone_repo_cmd}"

## IV - Making sure the intermediate publish director exists and is empty
pub_dir=${ROOT_PUB_DIR}/${version}
clear_publish_dir_cmd="mkdir -p ${pub_dir};
  rm -rf ${pub_dir}/*"
if [ ${verbose} == 1 ]; then
  printf "Clearing the publish directory:\n  %s\n\n" "${clear_publish_dir_cmd}"
fi
eval "${clear_publish_dir_cmd}"

### V - Create an archive ready to be published
artifact_filename=${ARTIFACT_BASENAME}-${version}.tar.gz
## Using a tar piped in a gzip to have a deterministic archive (ie the same file generated with the same content)
archive_cmd="tar cf - ${included_files[*]} |
  gzip --quiet -n > ${pub_dir}/${artifact_filename}"
if [ ${verbose} == 1 ]; then
  printf "Creating the artifact, ready to be published:\n  %s\n\n" "${archive_cmd}"
fi
eval "${archive_cmd}"

### VI - Create the commit, ready for publication !
GIT_PREPARE_COMMIT_CMD="cd ${pub_dir} &&
  git config user.name \"${PUBLISH_AUTHOR_NAME}\" &&
  git config user.email \"${PUBLISH_AUTHOR_EMAIL}\" &&
  git add ${artifact_filename}
"
if [ ${verbose} == 1 ]; then
  printf "Preparing the release commit:\n  %s\n\n" "${GIT_PREPARE_COMMIT_CMD}"
fi
eval "${GIT_PREPARE_COMMIT_CMD}"

GIT_COMMIT_CMD="git commit -q -m\"Version \"$version\" published\"  > /dev/null"
if [ ${verbose} == 1 ]; then
  printf "Committing the release:\n  %s\n\n" "${GIT_COMMIT_CMD}"
fi

ARTIFACT_URL="https://${GH_ORG}.github.io/${GH_REPO}/${version}/${artifact_filename}"

set +o errexit
if eval "${GIT_COMMIT_CMD}"; then
  printf "Nothing new to publish for version \"%s\".\n" "${version}"
  if [ ${dry_run} == 1 ]; then
    printf "DRY RUN SUCCESSFUL - Nothing published\n"
  else
    printf "Existing artifact can be retrieved at %s\n" "${ARTIFACT_URL}"
  fi
  exit 0
fi
set -o errexit

### VII - Push!
GIT_PUSH_CMD="git push origin ${GH_BRANCH} -q"
if [ ${verbose} == 1 ]; then
  printf "Publishing the artifact to GitHub pages:\n  %s\n\n" "${GIT_PUSH_CMD}"
fi
if [ ${dry_run} == 1 ]; then
  printf "DRY RUN SUCCESSFUL - Nothing published\n"
else
  eval "${GIT_PUSH_CMD}"

  printf "Publication of version \"%s\" successful!\n" "${version}"
  printf "Published artifact can be retrieved at %s\n" "${ARTIFACT_URL}"
fi
