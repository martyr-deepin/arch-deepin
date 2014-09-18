#!/bin/bash

pkgname="${1}"
pacman -Ql "${pkgname}" | awk '{print $2}' | sort | sed 's=/$==' > "${pkgname}"
