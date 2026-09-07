# Chiral Linux — Live ISO

## Download

- GitHub: `<paste your repo link here>`
- Google Drive: `<paste your Drive link here>`

## Run in VirtualBox

1. Open VirtualBox → **New**
   - Type: Linux, Version: Other Linux (64-bit)
   - RAM: 2048 MB+ recommended
   - Skip disk creation (or add one if you want persistence)
2. Select the VM → **Settings → Storage**
   - Click the empty optical drive → choose the downloaded `.iso` file
3. **Settings → System → Motherboard** → make sure boot order has Optical first
4. Start the VM

## At GRUB

You'll land on the GRUB menu. If it shows a `grub>` prompt instead of the menu, run:

```
ls
```

to see available drives (usually `(cd0)`), then:

```
set root=(cd0)
configfile /boot/grub/grub.cfg
```

This loads the menu manually — select the entry and press Enter to boot.

## After boot (login)

```
Login: root
Password: <your root password>
```

If you land on a text prompt instead of desktop, start XFCE manually:

```bash
mount -t tmpfs tmpfs /root
mkdir -p /root
echo "exec /usr/bin/startxfce4" > /root/.xinitrc
startx
```

(This step won't be needed once the auto-loading ISO build is used — this file covers the current version.)

## Notes

- This build boots via a custom busybox-based initramfs — no dracut.
- Some directories (`/var`, `/tmp`, `/run`, `/root`, `/home`) are tmpfs and reset on every reboot — nothing you save persists between boots.
- If keyboard doesn't respond at login, make sure you're using a PS/2-style input in VM settings, or check USB controller settings (xHCI vs OHCI) under **Settings → USB**.
