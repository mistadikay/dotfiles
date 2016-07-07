#!/usr/bin/env osascript

-- go to System Preferences -> Keyboard -> Shortcuts tab -> Mission Control
-- and then set shortcut ⌃⇧⌘D for “Turn Do Not Disturb On/Off”
ignoring application responses
    tell application "System Events" to keystroke "D" using {command down, control down, shift down}
end ignoring
