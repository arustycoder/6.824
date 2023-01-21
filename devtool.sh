#!/usr/bin/env sh

mode=$1

build_apps() {
    echo "Build mapreduce apps"
    rm -f target/"$1"/*.so
    cd mrapps && cargo build --"$1" --target-dir ../target; cd - >/dev/null 2>&1 || exit
    mv target/"$1"/libwc.so target/"$1"/wc.so
    mv target/"$1"/libindex.so target/"$1"/index.so
}

build_all() {
  build_apps release; echo "Build others"; cargo build --release
}

clean_all() {
  echo "Clean all"; cargo clean
}

if [ "$mode" = "build" ]; then
  pkg=$2
  if [ "$pkg" = "apps" ]; then
    build_apps release
  else
    build_all
  fi
elif [ "$mode" = "clean" ]; then
    clean_all
else
  echo "Invalid mode"
fi