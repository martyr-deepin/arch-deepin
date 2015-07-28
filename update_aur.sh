#!/bin/bash

for p in *; do
  if [ -d $p ]; then
    cp -vf ../aur/$p/PKGBUILD $p
    cp -vf ../aur/$p/*.install $p 2>/dev/null
  fi
done
