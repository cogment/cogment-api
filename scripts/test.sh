#!/usr/bin/env bash

ROOT_DIR=$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd)
TEST_DIR="${ROOT_DIR}/.testing"

set -o errexit

mkdir -p "${TEST_DIR}/cogment/api/"
cp "${ROOT_DIR}"/*.proto "${TEST_DIR}/cogment/api/"
protoc --proto_path="${TEST_DIR}" --descriptor_set_out="${TEST_DIR}/descriptor" "${TEST_DIR}"/cogment/api/*.proto
