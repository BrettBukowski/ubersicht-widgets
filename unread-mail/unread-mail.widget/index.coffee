command: """
osascript -e 'set newline to ASCII character 10
set finalText to ""
tell application id "com.apple.mail"
    set unreadCount to (get unread count of inbox)
    if unreadCount > 0 then
        set theMessages to (messages of inbox whose read status is false)
        set counter to 1
        repeat unreadCount times
            set thisMessage to item counter of theMessages
            set fromMsg to (sender of thisMessage as string)
            set subjMsg to (subject of thisMessage as string)
            set finalText to finalText & fromMsg & newline & "      " & subjMsg & newline
            set counter to counter + 1
        end repeat
    else
        set finalText to "No mail"
    end if
end tell
finalText'
"""

refreshFrequency: 2000

style: """
    top: 1%
    left: 2%
    font-family: 'Lucida Grande'
    font-size: 18px
    color: rgba(255, 255, 255, .8)

    div
        overflow: hidden

    .sender
        color: rgba(255, 255, 255, .6)
        width: 180px
        float: left
        font-size: 16px
        overflow: hidden
        text-overflow: ellipsis
        white-space: nowrap

    .subject
        float: left
        margin-left: 10px
"""

update: (output, domEl) ->
    formatted = []
    outputLines = output.split("\n")
    for e, i in outputLines by 2
        [sender, subject] = outputLines[i .. i + 1]
        formatted.push("""<div>
        <span class='sender'>#{sender}</span>
        <span class='subject'>#{subject}</span>
        </div>""")

    if formatted.length > 10
        formatted = formatted[0..10]

    $(domEl).html(formatted.join("\n"))
