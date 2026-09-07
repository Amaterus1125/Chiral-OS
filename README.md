<div align="center">

# 🐚 Chiral OS

**A hand-built Linux distribution powered by XFCE — compiled from source, not assembled from a base image.**

[![Built From Source](https://img.shields.io/badge/built%20from-source-8839ef?style=for-the-badge&logo=linux&logoColor=white)](#)
[![XFCE](https://img.shields.io/badge/desktop-XFCE-1e66f5?style=for-the-badge&logo=xfce&logoColor=white)](#)
[![License](https://img.shields.io/badge/license-MIT-40a02b?style=for-the-badge)](#license)
[![Status](https://img.shields.io/badge/status-active%20development-e64553?style=for-the-badge)](#roadmap)

</div>

---

## What is Chiral?

**Chiral OS** is a custom Linux distribution built from [Linux From Scratch](https://www.linuxfromscratch.org/) and [BLFS](https://www.linuxfromscratch.org/blfs/), with **XFCE** as its desktop environment. Every core package — toolchain, init flow, desktop stack — is compiled by hand rather than inherited from an upstream distro. It boots from a self-built live ISO using a custom BusyBox initramfs, and currently runs verified in a **VM** (QEMU/VirtualBox), with bare-metal driver support being expanded ahead of a full release.

## ✨ Highlights

- 🧱 **Built from source** — full LFS toolchain + BLFS package set, no upstream base distro
- 🖥️ **XFCE desktop** — lightweight, fast, and fully themed as the default experience
- 🎨 **Ricing built in** — Catppuccin / Nordic themes, Papirus icons, Bibata cursors, `picom`, `rofi`, `dunst`, `kitty`, `starship`, JetBrainsMono Nerd Font — shipped via `/etc/skel`
- 💿 **Custom live ISO** — hand-rolled BusyBox initramfs, `mksquashfs`, `grub-mkstandalone`, `xorriso`
- 📦 **Native package management** — integrating `xbps-src`, wrapping LFS `DESTDIR` builds into `.xbps` packages
- 📡 **Real hardware support** — NetworkManager GUI stack built from source, WiFi drivers debugged and working (including ath9k/ath9k_htc)

## 📊 Project Status

| Component | Status |
|---|---|
| Live ISO (x86_64) | ✅ Boots — verified in VM (QEMU/VirtualBox) |
| XFCE desktop + ricing | ✅ Working, set as default via `/etc/skel` |
| NetworkManager / WiFi | ✅ Built and working from source |
| Bare-metal boot | 🚧 Driver/hardware coverage in progress |
| `xbps-src` packaging | 🚧 In progress (Path A: `DESTDIR` → `.xbps`) |
| Calamares installer | 🚧 In progress |
| Distributable ISO | 🔜 Planned |

## 📥 Download

The ISO is currently distributed via Google Drive while releases are set up:

**[⬇️ Download chiral-live.iso](https://drive.google.com/file/d/1wxKLTWrWFhGB3HCN_wByQT9bIwV05XEM/view?usp=sharing)**

## 🚀 Booting the ISO

### GRUB boot entry (live ISO)

The ISO ships its own GRUB config, generated with `grub-mkstandalone`. On boot you'll land on a menu equivalent to:

```
menuentry "Chiral OS (Live)" {
    linux  /boot/vmlinuz boot=live quiet
    initrd /boot/initramfs.img
}
```

If you land at a GRUB rescue/command prompt instead of the menu, boot it manually with:

```
set root=(cd0)
linux (cd0)/boot/vmlinuz boot=live quiet
initrd (cd0)/boot/initramfs.img
boot
```

> 💡 Swap `(cd0)` for the correct device if your VM presents the ISO differently — check with `ls` at the GRUB prompt.

### Running in a VM

**QEMU:**
```bash
qemu-system-x86_64 \
  -enable-kvm \
  -m 4096 \
  -smp 2 \
  -cdrom chiral-live.iso \
  -boot d \
  -vga virtio \
  -display gtk
```

**VirtualBox:**
1. Create a new VM — Type: **Linux**, Version: **Other Linux (64-bit)**
2. Allocate at least **4GB RAM** and **2 CPUs**
3. Attach `https://drive.google.com/file/d/1wxKLTWrWFhGB3HCN_wByQT9bIwV05XEM/view?usp=sharing` as the optical drive
4. Enable **EFI** in *Settings → System* if booting via GRUB EFI mode
5. Boot — GRUB will load from the ISO automatically

## 🎨 Default Desktop Stack

| Layer | Tool |
|---|---|
| Desktop Environment | XFCE |
| Theme | Catppuccin / Nordic |
| Icons | Papirus |
| Cursor | Bibata |
| Compositor | picom |
| Launcher | rofi |
| Notifications | dunst |
| Terminal | kitty |
| Shell prompt | starship |
| Font | JetBrainsMono Nerd Font |

## 🗺️ Roadmap

- [ ] Broaden bare-metal hardware/WiFi driver support
- [ ] Land `xbps-src` packaging (Path A: wrap `DESTDIR` builds into `.xbps`)
- [ ] Ship Calamares installer
- [ ] Strip personal config for a clean distributable ISO
- [ ] First public ISO release

## 🤝 Contributing

Chiral OS is a solo-built distro that's opening up to contributions. Issues and PRs are welcome — especially around hardware compatibility, packaging, and desktop polish.

## 📜 License

Released under the [MIT License](LICENSE).

---

<div align="center">
Built from source, byte by byte. 🐧
</div>
