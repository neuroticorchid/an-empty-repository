#!/bin/bash
# neuroUI-brand.sh
# Applies neuroUI OS branding and command availability
# Run with sudo!

set -e

# Check for root
if [ "$EUID" -ne 0 ]; then 
  echo ":: Please run as sudo! (◕‿◕✿)"
  exit 1
fi

echo ":: Fetching neuroUI icon from GitHub..."
ICON_SRC="/tmp/neuroui-icon.png"
# Using your GitHub path
curl -fsSL https://raw.githubusercontent.com/neuroticorchid/an-empty-repository/main/neuroUI/icon.png -o "$ICON_SRC"

ICON_DEST="/usr/share/pixmaps/neuroui.png"
KDE_LOGO_DEST="/usr/share/plasma/look-and-feel/org.kde.breezedark.desktop/contents/assets/logo.png"

echo ":: Applying neuroUI branding..."

# --- /etc/os-release ---
tee /etc/os-release > /dev/null <<EOF
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

# --- /etc/lsb-release ---
tee /etc/lsb-release > /dev/null <<EOF
DISTRIB_ID=neuroUI
DISTRIB_RELEASE=rolling
DISTRIB_DESCRIPTION="neuroUI (based on Arch Linux)"
EOF

# --- Copy icon ---
cp "$ICON_SRC" "$ICON_DEST"
echo ":: Icon copied to $ICON_DEST"

# --- KDE About This System logo ---
if [ -f "$KDE_LOGO_DEST" ]; then
    cp "$ICON_SRC" "$KDE_LOGO_DEST"
    echo ":: KDE logo replaced"
else
    echo ":: KDE logo path not found, skipping (non-critical)"
fi

# --- Global Command Availability ---
echo ":: Setting up 'neuroui' command globally..."

# 1. For Fish (System-wide function)
FISH_FUNC_DIR="/etc/fish/functions"
mkdir -p "$FISH_FUNC_DIR"
cat << 'EOF' > "$FISH_FUNC_DIR/neuroui.fish"
# neuroUI Command Redirect for Fish
function neuroui
    # This calls the main neuroUI service file
    # Ensure your neuroUI Service script is sourced in config.fish 
    # or define the full logic here if preferred.
    command neuroui $argv
end
EOF

# 2. For Bash (System-wide alias/function)
cat << 'EOF' > /etc/profile.d/neuroui.sh
# neuroUI Command Redirect for Bash
neuroui() {
    # If you have the fish function version, we can invoke fish or 
    # point to a standalone script location.
    if command -v fish > /dev/null; then
        fish -c "neuroui $*"
    else
        echo "neuroUI Service requires Fish shell for full logic."
    fi
}
export -f neuroui
EOF

# --- fastfetch hint ---
# Since sudo changes $HOME, we look for the real user's home
REAL_USER=${SUDO_USER:-$USER}
USER_HOME=$(getent passwd "$REAL_USER" | cut -d: -f6)
FASTFETCH_CONFIG="$USER_HOME/.config/fastfetch/config.jsonc"

if [ -f "$FASTFETCH_CONFIG" ]; then
    echo ""
    echo ":: fastfetch config detected for $REAL_USER!"
    echo "    Add this to your config.jsonc to use the neuroUI icon:"
    echo '    "logo": { "source": "/usr/share/pixmaps/neuroui.png", "type": "kitty" }'
fi

# --- Cleanup ---
rm -f "$ICON_SRC"

echo ""
echo ":: neuroUI branding applied! (◕‿◕✿)"
echo ":: The 'neuroui' command is now available in Bash and Fish."
echo ":: Reboot or re-login to see changes."
