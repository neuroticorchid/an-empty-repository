#!/bin/bash

# --- THE FUNCTION ---
# Usage: neuro_popup "Title" "Message" "Passive_Time"
neuro_popup() {
    local TITLE="NeuroUI | $1"
    local MSG="$2"
    local TIME="${3:-5}" # Defaults to 5 seconds if not specified

    # Sends a themed passive notification
    kdialog --title "$TITLE" --passivepopup "$MSG" "$TIME"
}

# --- SCRIPT LOGIC ---

# 1. Main Welcome Dialog
kdialog --title "NeuroUI Login" \
        --msgbox "H-hello? Welcome back, $USER! (◕‿◕✿)\n\nSystem initialization complete. Heart."

# 2. Using the function to show system stats
MEM_FREE=$(free -h | awk '/^Mem:/ {print $4}')
neuro_popup "System Status" "I've checked your heart... and your RAM. You have $MEM_FREE free. Heart." 8

# 3. Using the function again for a sassy remark
neuro_popup "Mood" "I'm feeling extra digital today. Don't forget to update me later! (◕‸ ◕✿)" 5

#!/bin/bash

# --- THE FUNCTION ---
neuro_popup() {
    local TITLE="NeuroUI | $1"
    local MSG="$2"
    local TIME="${3:-5}"

    kdialog --title "$TITLE" --passivepopup "$MSG" "$TIME"
}

# --- SCRIPT LOGIC ---

# 1. Main Welcome Dialog (This pauses the script until you click OK)
kdialog --title "NeuroUI Login" \
        --msgbox "H-hello? Welcome back, $USER! (◕‿◕✿)\n\nSystem initialization complete. Heart."

# 2. Show passive popups in the background
MEM_FREE=$(free -h | awk '/^Mem:/ {print $4}')
neuro_popup "System Status" "I've checked your heart... and your RAM. You have $MEM_FREE free. Heart." 8

# 3. AUTOSTART THE SELECTOR
# Make sure this path matches where your selector script is located!
SELECTOR_PATH="$HOME/neuroUI-settings-and-dialogs/neuroUI-selector.sh"

if [ -f "$SELECTOR_PATH" ]; then
    bash "$SELECTOR_PATH"
else
    kdialog --error "H-hello? I tried to start the selector, but $SELECTOR_PATH is missing! (◕‸ ◕✿)"
fi
