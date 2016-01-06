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
sudo pacman -S deepin deepin-extra
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

License
-------

GNU General Public License, Version 3.0
