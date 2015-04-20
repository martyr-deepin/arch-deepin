# About update.sh

`update.sh` is a script that make updating deepin packages easily. It
will download the latest `Sources.gz` in deepin mirrors, then querying
the latest packages information and generating the new PKGBULDs
through their templates, finally it will deploy the PKGBULDs for AUR,
OBS and other repositories.

Here are some examples:

- update all packages

   ./update.sh

- update special packages

   ./update.sh -p startdde -p dde-workspace

- update packages but

   ./update.sh -n startdde -n dde-workspace

- run `makepkg' for packages

   ./update.sh --makepkg

- upload packages to AUR

   ./update.sh --upload-aur

Here is the full usage:

    update.sh [options]
    options:
        --no-download-reposources, -e
            do not download repo sources, use the existing one
        --package, -p
            only update target package, could use multiple times
        --no-package, -n
            ignore target package, could use multiple times
        --mark-updated, -m
            mark package(s) updated
        --makepkg, -M
            run makepkg for updated packages
        --upload-aur, -u
            upload updated packages to aur
        -h, --help
            show this message

# Run tests

    (cd test/; ./test.sh)
