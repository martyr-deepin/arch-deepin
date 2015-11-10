NOTE
====

Thanks @felixonmars, we could install `deepin-music`, `deepin-movie`
and many other Deepin software from `[community]` now. But the DDE
2015 related packages are still in process, and during the time, there
will be some conflicting packages, such as `deepin-api` in [community]
and `dde-api` in obs/arch-deepin. Please don't worry about it, mostly,
just choose the one in OBS and it will works fine.

arch-deepin
===========

Building Deepin Software on ArchLinux. They have a whole DE.

Install
-------

Add following code to `/etc/pacman.conf`:

```INI
[home_metakcahura_arch-deepin_Arch_Extra]
SigLevel = Never
Server = http://download.opensuse.org/repositories/home:/metakcahura:/arch-deepin/Arch_Extra/$arch
# Server = http://anorien.csc.warwick.ac.uk/mirrors/download.opensuse.org/repositories/home:/metakcahura:/arch-deepin/Arch_Extra/$arch
```

Then install `deepin`:

    sudo pacman -Sy deepin

If you want to experience more applications from Deepin, such as
`deepin-music` and `deepin-movie`, you could also install
`deepin-extra`:

    sudo pacman -Sy deepin-extra

Receive update notification
---------------------------

Anyone want to receive the news of arch-deepin please subscribe the [Changelog notification topic](https://github.com/fasheng/arch-deepin/issues/67).

Launching DDE
-------------

  We can use either lightdm or xinit to launch DDE, if use xinit,
  specific configuration is as follows:

  1. Add the following code to `$HOME/.xinitrc`

        exec startdde

  2. run xinit in tty to enter DDE

Troubleshooting
---------------

  - Memory leak issues in `deepin-terminal` and `deepin-music`

    This is caused by `pygtk`, and we provide an alternative package
    named `deepin-pygtk`, just install it.

  - Report package downgrading warning when updating

    Packages version format have been adjusted for that we do not use
    source git repositories right now. To fix this problem, just run
    `pacman -Syuu`.

  - Install deepin packages failed, report `Maximum file size
    exceeded` or `invalid or corrupted package (checksum)`

    Well, the repository site of openSUSE looks like not friendly to
    archlinux users. Please setup `wget` as default download tool by
    removing comment from line `XferCommand = /usr/bin/wget
    --passive-ftp -c -O%o %u` in `/etc/pacman.conf`, then try again.

    If not work, try the alternative server:

        Server = http://anorien.csc.warwick.ac.uk/mirrors/download.opensuse.org/repositories/home:/metakcahura:/arch-deepin/Arch_Extra/$arch

  - There are conflicting files when updating to dde-daemon-20141201.b14fbe0

    I'm afraid we have to remove the conflicting files manually:

        sudo rm /usr/share/personalization/thumbnail/autogen/*.png

  - How to report debugging information of deepin?

    Just use journalctl, for example, the following command will
    print all deepin related log messages since boot:

       journalctl -b | grep -i 'deepin'

  - Why network in deepin-control-center not working?

    LinuxDeepin manage network through NetworkManager, so don't
    forget to start it,

        sudo systemctl start NetworkManager

    And if you want to experience DDE for a long time, using
    NetworkManager instead of netctl is a better choice,

        sudo systemctl stop netctl
        sudo systemctl disable netctl
        sudo systemctl stop netctl@ethernetdhcp
        sudo systemctl disable netctl@ethernetdhcp
        sudo systemctl enable NetworkManager
        sudo systemctl start  NetworkManager
        sudo systemctl enable ModemManager
        sudo systemctl start ModemManager

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
