command: "tmutil status"

refreshFrequency: 2000

style: """
  top: 10px
  left: 12%
  color: #fff
  font-family: ARCFont
  font-size: 96px

"""


render: (output) -> """

"""

update: (output, domEl) ->
  return unless output.match(/Running = 1;/)
  alphabet = [ 'a', 'b', 'c', 'd', 'e', 'f', 'g', 'h', 'i', 'j', 'k', 'l', 'm', 'n', 'o', 'p', 'q', 'r', 's', 't', 'u', 'v', 'w', 'x', 'y', 'z', 'A', 'B', 'C', 'D', 'E', 'F', 'G', 'H', 'I', 'J', 'K', 'L', 'M', 'N', 'O', 'P', 'Q', 'R', 'S', 'T', 'U', 'V', 'W', 'X', 'Y' ]

  percent = output.match(/\s+Percent = "?(\d(?:\.\d+)?)"?;/)

  if percent && percent[1]
    percent = parseInt(parseFloat(percent[1]) * 100 / 2)
    $(domEl).html(alphabet[percent])
