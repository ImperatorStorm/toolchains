#!/usr/bin/env bash
repo=$1
triple=$2
if [[ -z "$repo" ]]; then
  echo "Usage: ./bootstrap <repo> <triple>"
  exit
fi
if [[ -z "$triple" ]]; then
  echo "Usage: ./bootstrap <repo> <triple>"
  exit
fi

build() {
  pushd $1
  shift
  sudo makechrootpkg -r /var/lib/archbuild/${repo}-x86_64/ -- -i -r $@
  popd
}

${repo}-x86_64-build -c
build ${triple}/linux-api-headers
build ${triple}/binutils --nocheck
build ${triple}/gcc-stage1 --nocheck
build ${triple}/glibc-headers --nocheck
build ${triple}/gcc-stage2 --nocheck
#build ${triple}/glibc --nocheck
#build ${triple}/gcc --nocheck
#build ${triple}/glibc
#build ${triple}/gcc
