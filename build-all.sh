#!/usr/bin/env bash

set +e

go version

${BASH_VERSINFO[0]}

mapfile -t dists <<<"$(go tool dist list)"

export CGO_ENABLED=0

printf "Building for %d os/architectures (CGO_ENABLED=%s)\n" "${#dists[@]}" "${CGO_ENABLED}"

fails=()
for dist in "${dists[@]}"; do
    os="${dist%%/*}"
    arch="${dist#*/}"
    printf "Building %s...\n" "${dist}"
    GOOS="${os}" GOARCH="${arch}" go build . || fails+=("${dist}")
done

export CGO_ENABLED=1

printf "Building for %d os/architectures (CGO_ENABLED=%s)\n" "${#fails[@]}" "${CGO_ENABLED}"

cgo_fails=()
for dist in "${fails[@]}"; do
    os="${dist%%/*}"
    arch="${dist#*/}"
    printf "Building %s...\n" "${dist}"
    GOOS="${os}" GOARCH="${arch}" go build . || cgo_fails+=("${dist}")
done

printf "%d of %d builds failed (CGO_ENABLED=0):\n" "${#fails[@]}" "${#dists[@]}"
printf "%s\n" "${fails[@]}"

printf "%d of %d builds failed (CGO_ENABLED=1):\n" "${#cgo_fails[@]}" "${#dists[@]}"
printf "%s\n" "${cgo_fails[@]}"
