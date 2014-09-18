#!/bin/bash

pkgname="${1}"
dpkg -L "${pkgname}" | sort > "${pkgname}"
