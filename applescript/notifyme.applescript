#!/usr/bin/env osascript

-- see http://frantic.im/notify-on-completion
on run argv
  tell application "System Events"
    set frontApp to name of first application process whose frontmost is true
    if frontApp is not "HyperTerm" then
      set notifTitle to item 1 of argv
      set notifBody to "succeded"
      set errorCode to item 2 of argv
      if errorCode is not "0"
        set notifBody to "failed with error code " & errorCode
      end if
      display notification notifBody with title notifTitle
    end if
  end tell
end run
