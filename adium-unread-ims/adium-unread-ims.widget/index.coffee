command: """
osascript -e 'tell application "System Events" to set adiumisrunning to (name of processes) contains "Adium"
if adiumisrunning then
    tell application "Adium"
        set tabs to count of chats
        set unreads to 0
        repeat with loopi from 1 to tabs
            set unreads to unreads + (unread message count of chat loopi)
        end repeat
        if unreads is equal to 1 then
            return "1 unread IM"
        else if unreads is not equal to 0 then
            return (unreads as string) & " unread IMs"
        end if
    end tell
end if'
"""

refreshFrequency: 10000

style: """
    top: 60%
    left: 2%
    font-family: 'Lucida Grande'
    font-size: 18px
    color: rgba(255, 255, 255, .8)
"""

render: (output) -> """
#{output}
"""

update: (output, domEl) ->
    $(domEl).html(output)