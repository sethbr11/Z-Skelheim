#!/bin/zsh

function check_accessibility_permissions() {
    osascript -e "return true" > /dev/null 2>&1
    if [[ $? -ne 0 ]]; then
        echo "Error: Accessibility permissions are not enabled for Terminal or your script."
        echo "Please enable these permissions in System Preferences > Security & Privacy > Privacy > Accessibility."
        return 1
    fi
}