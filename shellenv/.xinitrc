#!/bin/sh

userresources=$HOME/.Xresources
usermodmap=$HOME/.Xmodmap
sysresources=/etc/X11/xinit/.Xresources
sysmodmap=/etc/X11/xinit/.Xmodmap

# merge in defaults and keymaps
if [ -f $sysresources ]; then
    xrdb -merge $sysresources
fi

if [ -f $sysmodmap ]; then
    xmodmap $sysmodmap
fi

if [ -f "$userresources" ]; then
    xrdb -merge "$userresources"
fi

if [ -f "$usermodmap" ]; then
    xmodmap "$usermodmap"
fi

# start some nice programs
if [ -d /etc/X11/xinit/xinitrc.d ] ; then
 for f in /etc/X11/xinit/xinitrc.d/?*.sh ; do
  [ -x "$f" ] && . "$f"
 done
 unset f
fi

# udiskie &
# autocutsel -fork &
# autocutsel -selection PRIMARY -fork &
# exec i3
# Here Xfce is kept as default
session=${1:-xmonad}

case $session in
    i3|i3wm           ) exec i3;;
    kde               ) exec startkde;;
    xfce|xfce4        ) exec startxfce4;;
    xmonad )
      PATH=$PATH:~/.xmonad/bin
      xsetroot -cursor_name left_ptr &
      xrdb -merge ~/.Xresources &
      setxkbmap -option "ctrl:nocaps" &
      compton -CGb &
      tray &
      gnome-terminal &
      gnome-terminal &
      chromium &
      gnome-screensaver &
      pulseaudio --start --log-target=syslog &
      gnome-session &
      exec xmonad
      ;;
    # No known session, try to run it as command
    *                 ) exec $1;;
esac
