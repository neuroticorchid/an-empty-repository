#!/bin/bash
# neuroUI-brand.sh
# Run with sudo!

set -e

ICON_SRC="$HOME/Downloads/icon.png"
ICON_DEST="/usr/share/pixmaps/neuroui.png"
KDE_LOGO_DEST="/usr/share/plasma/look-and-feel/org.kde.breezedark.desktop/contents/assets/logo.png"

echo ":: Applying neuroUI branding..."

# --- /etc/os-release ---
sudo tee /etc/os-release > /dev/null <<EOF
NAME="neuroUI"
PRETTY_NAME="neuroUI"
ID=arch
ID_LIKE=arch
BUILD_ID=rolling
ANSI_COLOR="38;2;23;147;209"
HOME_URL="https://orchidneurons.neocities.org"
DOCUMENTATION_URL="https://wiki.archlinux.org/"
SUPPORT_URL="https://bbs.archlinux.org/"
BUG_REPORT_URL="https://github.com/neuroticorchid"
LOGO=neuroui
EOF

# --- /etc/lsb-release (for tools that read this) ---
sudo tee /etc/lsb-release > /dev/null <<EOF
DISTRIB_ID=neuroUI
DISTRIB_RELEASE=rolling
DISTRIB_DESCRIPTION="neuroUI is a Neuro-sama fan-made Operating System based on Arch Linux"
EOF

# --- Copy icon ---
sudo cp "$ICON_SRC" "$ICON_DEST"
echo ":: Icon copied to $ICON_DEST"

# --- KDE About This System logo (optional, skip if path doesn't exist) ---
if [ -f "$KDE_LOGO_DEST" ]; then
    sudo cp "$ICON_SRC" "$KDE_LOGO_DEST"
    echo ":: KDE logo replaced"
else
    echo ":: KDE logo path not found, skipping (non-critical)"
fi

# --- fastfetch custom logo (if you use an image logo) ---
FASTFETCH_CONFIG="$HOME/.config/fastfetch/config.jsonc"
if [ -f "$FASTFETCH_CONFIG" ]; then
    echo ":: fastfetch config found — you may want to set logo.source to $ICON_DEST manually"
fi

echo ""
echo ":: neuroUI branding applied! (◕‿◕✿)"
echo ":: Reboot or r
