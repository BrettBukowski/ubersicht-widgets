command: """
osascript -e 'set newline to ASCII character 10
set finalText to ""
tell application id "com.apple.mail"
    set unreadCount to (get unread count of inbox)
    if unreadCount > 0 then
        set theMessages to (messages of inbox whose read status is false)
        repeat with i from 1 to number of items in theMessages
            set thisMessage to item i of theMessages
            set fromMsg to (sender of thisMessage as string)
            set subjMsg to (subject of thisMessage as string)
            set finalText to finalText & fromMsg & newline & "      " & subjMsg & newline
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
        width: 150px
        float: left
        overflow: hidden
        text-overflow: ellipsis

    .subject
        float: left
        margin-left: 10px
"""

render: (output) -> """
#{output}
"""

update: (output, domEl) ->
    formatted = []
    outputLines = output.split("\n")
    for e, i in outputLines by 2
        [sender, subject] = outputLines[i .. i + 1]
        formatted.push("<div>")
        formatted.push("<span class='sender'>#{sender}</span>")
        formatted.push("<span class='subject'>#{subject}</span>")
        formatted.push("</div>")

    # Ever since Mavericks, `(messages of inbox whose read status is false)`
    # returns _all_ unread messages (not limited to just inbox).
    if formatted.length > 10
        formatted = formatted[0..10]

    $(domEl).html(formatted.join("\n"))
