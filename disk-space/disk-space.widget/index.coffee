command: "df -hl | grep 'disk0s2' | awk '{sub(/%/, \"\");print $4; print $5}'"

refreshFrequency: 2000

style: """
  top: 1%
  left: 2%
  color: #fff
  font-family: Futura
  line-height: 26pt

  .percent
    font-size: 35pt
  .percent::after
    content: "%"
    font-size: 20pt
    line-height: 0
  .gb
    font-size: 11pt
    color: rgba(255, 255, 255, .8)

"""

render: () -> """
  <span class='label'>disk space</span>
  <div class='percent'></div>
  <div class='gb'></div>
"""

update: (output, domEl) ->
  [gb, percent] = output.split("\n")
  $(domEl).find('.percent').html(percent)
  $(domEl).find('.gb').html("#{gb.replace('Gi', ' gb')}")
