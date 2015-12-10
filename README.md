NOTE
====

Thanks @mmetak and @felixonmars, we could install `deepin-music`,
`deepin-movie` and many other Deepin software from `[community]`
now.

For the old OBS users, please remove OBS repository from
`/etc/pacman.conf` and update packages through `sudo pacman -Syyuu`.

arch-deepin
===========

Building Deepin Software on ArchLinux. They have a whole DE.

Install
-------

For the DDE(Deepin Desktop Environment), simple install packages in
`deepin` group:

```sh
sudo pacman -Sy deepin
```

If you want to experience more applications from Deepin, such as
`deepin-music` and `deepin-movie`, just install `deepin-extra`:

```sh
sudo pacman -Sy deepin-extra
```

For the old Deepin 2014 packages which maintained by @mmetak, please
use the OBS repository by adding following code to `/etc/pacman.conf`:

```ini
[home_metakcahura_arch-deepin_Arch_Extra]
SigLevel = Never
Server = http://download.opensuse.org/repositories/home:/metakcahura:/arch-deepin/Arch_Extra/$arch
# Server = http://anorien.csc.warwick.ac.uk/mirrors/download.opensuse.org/repositories/home:/metakcahura:/arch-deepin/Arch_Extra/$arch
```

Receive update notification
---------------------------

Anyone want to receive the news of arch-deepin please subscribe the [Changelog notification topic](https://github.com/fasheng/arch-deepin/issues/67).

Launching DDE
-------------

  We can use either lightdm or xinit to launch DDE, if use xinit,
  specific configuration is as follows:

  1. Add the following code to `$HOME/.xinitrc`

     ```sh
     exec startdde
     ```

  2. run xinit in tty to enter DDE

     ```sh
     xinit
     ```

Troubleshooting
---------------

  - Install Deepin packages from OBS failed, report `invalid or corrupted package (checksum)`

    Well, this is a troublesome issue of OBS for Archlinux users that
    the the checksums will be out of date after package rebuild
    without version changed. Sometimes we will increase `pkgrel`
    manually to avoid such issues, but most of the cases, please
    install the packages manually through `pacman -U`.

  - Install Deepin packages from OBS failed, report `Maximum file size
    exceeded`

    The repository site of openSUSE looks like not friendly to
    archlinux users. Please setup `wget` as default download tool by
    removing comment from line `XferCommand = /usr/bin/wget
    --passive-ftp -c -O%o %u` in `/etc/pacman.conf`, then try again.

    If not work, try the alternative server:

    ```sh
    Server = http://anorien.csc.warwick.ac.uk/mirrors/download.opensuse.org/repositories/home:/metakcahura:/arch-deepin/Arch_Extra/$arch
    ```

  - Report package downgrading warning when updating

    Packages version format have been adjusted for that we do not use
    source git repositories right now. To fix this problem, just run
    `pacman -Syuu`.

  - How to collect debug logs?

    Just use journalctl, for example, the following command will
    print all Deepin related syslog messages since boot:

    ```sh
    journalctl -b | grep -i 'deepin'
    ```

    For xsession errors, Xorg logs in `~/.xsession.erros` and
    `/var/log/Xorg.0.log` will be very helpful for developers.

  - Why network in deepin-control-center not working?

    Deepin manage network through NetworkManager, so don't
    forget to start it,

    ```sh
    sudo systemctl start NetworkManager
    ```

    And if you want to experience DDE for a long time, using
    NetworkManager instead of netctl is a better choice,

    ```sh
    sudo systemctl stop netctl
    sudo systemctl disable netctl
    sudo systemctl stop netctl@ethernetdhcp
    sudo systemctl disable netctl@ethernetdhcp
    sudo systemctl enable NetworkManager
    sudo systemctl start  NetworkManager
    sudo systemctl enable ModemManager
    sudo systemctl start ModemManager
    ```

Screenshots
-----------

<img src="./screenshot/dde_2014.1_01.png"
width=500/>

<img src="./screenshot/dde_2014.1_02.png"
width=500/>

<img src="./screenshot/dde_2014.1_03.png"
width=500/>

License
-------

GNU General Public License, Version 3.0
