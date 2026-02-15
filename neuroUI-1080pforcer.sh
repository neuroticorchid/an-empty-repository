#!/bin/bash

# Configuration
TITLE="the forcer already is on your folder /home/$USER/.config/neuroUI-display.desktop)"
DESCRIPTION="NeuroUI has detected the display forcer is active.

Would you like to keep the current 1080p settings, or should I revert everything back to your monitor's native resolution?"

# Launching the dialog
# --yes-label renames the 'Yes' button
# --no-label renames the 'No' button
kdialog --title "$TITLE" \
        --yes-label "OK <3" \
        --no-label "Revert to native resolution" \
        --warningyesno "$DESCRIPTION"

# Capture the response
RESPONSE=$?

if [ $RESPONSE -eq 0 ]; then
    # User clicked OK <3
    kdialog --passivepopup "Settings confirmed. Staying cute at 1080p! Heart." 3
else
    # User clicked Revert to native resolution
    display=$(xrandr | grep " connected" | cut -d ' ' -f1 | head -n 1)
    xrandr --output "$display" --auto
    kdialog --passivepopup "Reverting to native resolution... Done! (◕‿◕✿)" 3
fi
