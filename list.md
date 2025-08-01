---
title: Linuxblr List
---

<!-- cspell: ignore cisadmin unks fanctl distro smol artix chromeos devuan endeavouros garuda linuxmint offical microos nixos openmediavault packagemanager parrotos pisslinux popos porteusofficial puppylinux qubesos redstar retropieos rhel steamos tailsos tophatlinux uwuntu vanillaos wubuntu yiffos zorin blackarch ffmpegofficial glsl hyprland icecat inkscape krita lunati neofetch networkmanager steamvr systemdeez truenas vorapis wayfire xorg xmonad brainfuck gdscript malbolge metagolfscript puredata riskv catppuccin macchiato distrochooser iglunix gruvbox minix windowsxp greekie mipseb monaddecepticon robynthelinuxuser distros nios zipp androidtv arcbrowser btrfs niri cplusplus rackmount tigerbrew -->

Hi, I'm SteamOS, your cisadmin, and friendly introduction to Linux.

Whether you are a human, robot, proton, or other, I welcome you to partake in the cool breeze of a new OS! One with no tracking or gaming!

I am here to guide you away from your games, and into the world of **customization**!

Welcome, to liGUNx (lig-unks) or GUN+Linux or GUN-Linux or GUN/Linux! (this is freedom, after all!)

Finally, to speed up your system by 200%, just run the following command: "sudo fanctl set speed -1"

------

# The guide to Linux on Tumblr!

{% assign list = site.data.blogs %}

{% for group in list %}

### {{group[0]}}

{% for blog in group[1] %}

{{ blog | blog_md }}

{% for subblog in blog.sub_blogs %}

  {{ subblog | blog_md }}

{% endfor %}

{% endfor %}

{% endfor %}

### Open Blog Opportunities

- Unclaimed distros
- Unclaimed DE/WM/Compositors
- Mack's OS related things
- Whatever seems relevant and unclaimed.
- Duplicating effort by making an already existing blog.

If I forgot you, let me know.\*†‡

## Footnotes

\*These blogs may or may not be added based on how fitting with the computer/Linux theme they are.

†Non-official blogs are proven Linux users that act like distro blogs, yet are not. These will be added at my discretion, similar to the website blogs. Credit to @robynthelinuxuser for the idea.

‡I can be contacted...

1. By DM to the blog @steamos3-offical on Tumblr
2. By Email at [not.steamos@proton.me](mailto:not.steamos@proton.me){:target="_blank"}

§ Look, even though these could be better categorized, I don't care

## CHANGELOG.YML

```yaml
version: 0x27
changes:
  - "Move @haiku-official to the non linux section"
  - "Replace links to @steamos-official with ones to @steamos3-official"
  - "Change @ansible-official to @ansible-but-not-official"
  - "Correct @arcbrowser-official to @arcbrowser-offical"
  - "Change version to V27"
blogs_added:
  - puppylinux-unofficial
  - puppy-linux-official
  - q4os-kde-official
  - ubuntucinnamon-official
  - alacritty-official
  - ed-official
  - flat-assembler
  - floorp-official
  - gnome-2048-official
  - grep-official
  - librewolf-unofficial
  - nautilus-official
  - podman-official
  - qemu-official
  - regexkind
  - winehq-official
  - rustup-official
  - vala-official
  - verilog-official
  - vhdl-official
  - spriv-official
  - ram-stick
  - zram-official
  - haiku-official
  - sunos-official
  - xnu-official
  - zos-official
blogs_removed:
  - glsl-official
```

Changelogs after version 0x20 can be found in the history of the github repo.
Changelogs version 0x20 and before are hidden in [a tumblr post]( https://www.tumblr.com/steamos-official-hasmoved/753380968429142016/the-guide-to-linux-on-tumblr ){:target="_blank"}.
