# Dotfiles for ajatters

> https://tatsumoto.neocities.org/

Configuration files and scripts I use in my computing.

![screenshot](https://user-images.githubusercontent.com/69171671/151655369-699b6e83-e0ef-47e0-986e-be786717c917.png)

## Programs used

* Distro - [Arch Linux](https://archlinux.org/)
* Shell - zsh + [zsh-theme-powerlevel10k](https://archlinux.org/packages/community/x86_64/zsh-theme-powerlevel10k/)
* Terminal - [Alacritty](https://wiki.archlinux.org/title/Alacritty)
* WM - [i3-wm](https://archlinux.org/packages/community/x86_64/i3-wm/).
* Status bar - [i3blocks](https://archlinux.org/packages/community/x86_64/i3blocks/)
* Launcher - [rofi](https://archlinux.org/packages/community/x86_64/rofi/)
* File Manager - [lf](https://github.com/gokcehan/lf)
* Image viewer and manga reader - [nsxiv](https://wiki.archlinux.org/title/Sxiv)
* Manga OCR - [transformers-ocr](https://github.com/Ajatt-Tools/transformers_ocr)
* Video player - [mpv](https://wiki.archlinux.org/title/Mpv) + [scripts](https://github.com/search?q=topic%3Ampv+org%3AAjatt-Tools+fork%3Atrue&type=repositories)
* Renaming files - [vidir](https://aur.archlinux.org/packages/vidir)
* Volume - [pamixer](https://archlinux.org/packages/extra/x86_64/pamixer/)
* Music - [mpd](https://wiki.archlinux.org/title/Music_Player_Daemon)+[ncmpcpp](https://wiki.archlinux.org/title/Ncmpcpp)
* Passive immersion - [impd](https://github.com/Ajatt-Tools/impd)
* Preview images in terminal - [ueberzug](https://archlinux.org/packages/?name=ueberzug) / ueberzugpp
* RSS reader - [newsboat](https://wiki.archlinux.org/title/Newsboat)
* Various scripts in [~/.local/bin/](.local/bin)
* Handy [aliases](.config/shell/aliasrc) and [functions](.config/shell/functionrc)

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

Use the [dot](.config/shell/aliasrc#L56) command to manage your dotfiles.
For example, `dot status` or `dot add <file>`.
For more information, see
[Tracking dotfiles with Git](https://wiki.archlinux.org/title/Dotfiles#Tracking_dotfiles_directly_with_Git).

## Credits

Certain config files, parts of files and scripts are based on
[voidrice](https://github.com/LukeSmithxyz/voidrice).
