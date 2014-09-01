# Description

A collection of software from Linux Deepin that ported to Archlinux,
you could find them in
[AUR](https://aur.archlinux.org/packages/?O=0&C=0&SeB=nd&K=deepin&outdated=&SB=n&SO=a&PP=50&do_Search=Go),

And now, thanks @metak's great job, we could install all them more easily
through his OBS repository, just add following code to
/etc/pacman.conf (if you download or checking package with problems,
just use the alternative server)

    [home_metakcahura_arch-deepin_Arch_Extra]
    SigLevel = Never
    Server = http://download.opensuse.org/repositories/home:/metakcahura:/arch-deepin/Arch_Extra/$arch
    #Server = http://anorien.csc.warwick.ac.uk/mirrors/download.opensuse.org/repositories/home:/metakcahura:/arch-deepin/Arch_Extra/$arch

Then
    
    sudo pacman -Sy deepin
  
More information to see the [topic](https://bbs.archlinux.org/viewtopic.php?id=181861).

# Launch DDE
  We can use either lightdm or xinit to launch DDE, if use xinit,
  specific configuration is as follows:
  
  1. Add the following code to `$HOME/.xinitrc`
  
     exec startdde
        
  2. run xinit in tty to enter DDE
  
  
  *Notice: this is still a testing version, if desktop blocked for
   issues, just kill startdde in another tty, :-)*
  
# Troubleshooting
  - How to report debugging information of deepin?
    
    Just use journalctl, for example, the following command will
    print all deepin related log messages since boot:

       journalctl -b | grep -i 'deepin'
  
  - Why network in deepin-control-center not working?
  
    LinuxDeepin manage network through NetworkManager, so don't
    forget to start it,
     
        sudo systemctl start NetworkManager
     
    And if you want to experience DDE for a long time, use
    NetworkManager instead of netctl is a better choice,
     
        sudo systemctl stop netctl
        sudo systemctl disable netctl
        sudo systemctl stop netctl@ethernetdhcp
        sudo systemctl disable netctl@ethernetdhcp
        sudo systemctl enable NetworkManager
        sudo systemctl start  NetworkManager
        sudo systemctl enable ModemManager
        sudo systemctl start ModemManager

  - Why I couldn't change user icon in account panel?

    You need install `polkit-gnome` or other authentication agents and
    make it autstarted on login,

        cp /usr/share/applications/polkit-gnome-authentication-agent-1.desktop /etc/xdg/autostart/
        sed -i 's/\(OnlyShowIn=.*\)/\1Deepin;/' /etc/xdg/autostart/polkit-gnome-authentication-agent-1.desktop 

# Screenshot

<img src="./screenshot/dde_2014.1_01.png"
width=500/>

<img src="./screenshot/dde_2014.2_02.png"
width=500/>

<img src="./screenshot/dde_2014.3_03.png"
width=500/>

# License

GNU General Public License, Version 3.0
