# Dotfiles for ajatters

> https://tatsumoto.neocities.org/

Configuration files and scripts I use in my computing.
This repo is a work in progress.

## Programs used

* Distro - Arch Linux
* Shell - zsh + [zsh-theme-powerlevel10k](https://archlinux.org/packages/community/x86_64/zsh-theme-powerlevel10k/)
* Terminal - alacritty
* WM - [i3-wm](https://archlinux.org/packages/community/x86_64/i3-wm/) (without gaps)
* Launcher - [rofi](https://archlinux.org/packages/community/x86_64/rofi/)
* File Manager - [lf](https://github.com/gokcehan/lf)
* Image viewer - sxiv
* Video player - mpv
* Renaming files - vidir
* Music - mpd+ncmpcpp
* Various scripts in `~/.local/bin/`

## Installation

I assume you run a distro based on Arch Linux.
If not, I can't guarantee all the scripts and configs will work.
You can still fork this repo and adjust them for your needs, if necessary.

Run the following commands in order.

```
git clone --depth 1 --recurse-submodules "https://github.com/tatsumoto-ren/dotfiles.git" ~/dots
cp -rfT ~/dots ~/
cp -rf ~/.git ~/.config/dotfiles
rm -rf -- ~/dots ~/.git
```

Then relogin.

## Usage

Use the [dot](.config/shell/aliasrc#L46) command to manage your dotfiles.
For example, `dot status` or `dot add <file>`.

## Credits

Certain config files, parts of files and scripts are based on
[voidrice](https://github.com/LukeSmithxyz/voidrice).
