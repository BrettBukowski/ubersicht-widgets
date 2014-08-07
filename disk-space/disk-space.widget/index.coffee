command: "df -hl | grep 'disk0s2' | awk '{sub(/%/, \"\");print $5}'"

refreshFrequency: 2000

style: """
  top: 1%
  left: 2%
  color: #fff
  font-family: Futura
  font-size: 35pt
  line-height: 26pt

  .label
    font-size: 12pt

"""

render: (output) -> """
  <span class='label'>disk space</span>
  <div class='percent'>#{output}%<div>
"""
