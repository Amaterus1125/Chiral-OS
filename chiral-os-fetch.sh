#!/usr/bin/env bash
# chiral-os-fetch.sh
# A fun little "fetch" script for the Chiral-OS repo (Amaterus1125/Chiral-OS)
# Pulls live data from GitHub and prints it neofetch-style.

set -euo pipefail

REPO="Amaterus1125/Chiral-OS"
API="https://api.github.com/repos/$REPO"

if ! command -v curl >/dev/null 2>&1; then
  echo "Need curl installed to talk to GitHub. Try: sudo apt install curl"
  exit 1
fi

data=$(curl -fsSL "$API") || { echo "Couldn't reach GitHub. Check your connection."; exit 1; }

get() { echo "$data" | grep -o "\"$1\":[^,}]*" | head -1 | sed -E "s/\"$1\": ?//; s/\"//g"; }

stars=$(get stargazers_count)
forks=$(get forks_count)
watchers=$(get watchers_count)
issues=$(get open_issues_count)
lang=$(get language)
updated=$(get updated_at)
desc=$(get description)

cat <<'ASCII'
        _____ _   _ _              _
       / ____| | | (_)            | |
      | |    | |_| |_ _ __ __ _  | |
      | |    |  _  | | '__/ _` | | |
      | |____| | | | | | | (_| | |_|
       \_____|_| |_|_|_|  \__,_| (_)
       hand-built. compiled from source. rice-loaded.
ASCII

echo "-------------------------------------------------"
printf "  %-12s %s\n" "Repo:"      "$REPO"
printf "  %-12s %s\n" "About:"     "$desc"
printf "  %-12s %s\n" "Language:"  "${lang:-Shell/ASM/Docs}"
printf "  %-12s  %s\n" "Stars:"    "$stars"
printf "  %-12s  %s\n" "Forks:"    "$forks"
printf "  %-12s  %s\n" "Watchers:" "$watchers"
printf "  %-12s  %s\n" "Issues:"   "$issues"
printf "  %-12s %s\n" "Updated:"  "$updated"
echo "-------------------------------------------------"

echo
echo " Desktop stack: XFCE + Catppuccin/Nordic, picom, rofi, dunst, kitty, starship"
echo " Boots via: custom BusyBox initramfs + grub-mkstandalone + xorriso"
echo
read -rp "Clone the repo now? [y/N] " ans
if [[ "$ans" =~ ^[Yy]$ ]]; then
  git clone "https://github.com/$REPO.git"
  echo " Cloned. Go build something from scratch, byte by byte. "
else
  echo "No worries — grab it anytime: https://github.com/$REPO"
fi
