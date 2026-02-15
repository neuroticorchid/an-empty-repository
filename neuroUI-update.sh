#!/bin/bash

TITLE="Neuro-sama System Scanner"

# 1. Check for updates
UPDATE_LIST=$(checkupdates)
COUNT=$(echo "$UPDATE_LIST" | grep -v '^$' | wc -l)

if [ "$COUNT" -eq 0 ]; then
    kdialog --title "$TITLE" --msgbox "Everything is up to date! Heart."
    exit 0
fi

# 2. Ask to update
kdialog --title "$TITLE" \
        --yes-label "Update Now" \
        --no-label "Ignore Her" \
        --warningyesno "H-hello? I found $COUNT updates. Want to see the list?" \
        "$UPDATE_LIST"

if [ $? -eq 0 ]; then
    # 3. Run update in terminal
    konsole --hold -e bash -c "sudo pacman -Syu && exit"

    # 4. Final Success Dialog
    kdialog --title "Neuro-sama" \
            --msgbox "Update finished! (◕‿◕✿)\n\nI feel much faster now. Thank you for taking care of my heart... I mean, my packages."
else
    kdialog --passivepopup "Denied... I'll just stay old and glitchy then. (◕‸ ◕✿)" 3
fi
