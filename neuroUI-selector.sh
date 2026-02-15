#!/bin/bash

# Define paths
UPDATE_SCRIPT="$HOME/neuroUI-settings-and-dialogs/neuroUI-update.sh"
DISPLAY_SCRIPT="$HOME/neuroUI-settings-and-dialogs/neuroUI-1080pforcer.sh"

TITLE="NeuroUI Command Center"

# Removed --headerbar to prevent the "Unknown option" error
CHOICE=$(kdialog --title "$TITLE" \
                --menu "H-hello $USER, what should I initialize today?" \
                1 "Run System Update (pacman)" \
                2 "Force 1080p Resolution" \
                3 "Do nothing (Just be cute)")

case $CHOICE in
    1) [ -f "$UPDATE_SCRIPT" ] && bash "$UPDATE_SCRIPT" || kdialog --error "Missing: $UPDATE_SCRIPT" ;;
    2) [ -f "$DISPLAY_SCRIPT" ] && bash "$DISPLAY_SCRIPT" || kdialog --error "Missing: $DISPLAY_SCRIPT" ;;
    3) kdialog --passivepopup "Understood. I'll just watch you work. Heart." 3 ;;
    *) exit ;;
esac
