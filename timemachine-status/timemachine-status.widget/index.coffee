command: "tmutil status"

refreshFrequency: 2000

style: """
  top: 10px
  left: 12%
  color: #fff
  font-family: ARCFont
  font-size: 96px

  .status
    font-family: 'Lucida Grande'
    font-size: 12px
    margin-top: 40px
"""

render: () -> """
  <div class='status'></div>
  <div class='percentage'></div>
"""

alphabet: [ 'a', 'b', 'c', 'd', 'e', 'f', 'g', 'h', 'i', 'j', 'k', 'l', 'm', 'n', 'o', 'p', 'q', 'r', 's', 't', 'u', 'v', 'w', 'x', 'y', 'z', 'A', 'B', 'C', 'D', 'E', 'F', 'G', 'H', 'I', 'J', 'K', 'L', 'M', 'N', 'O', 'P', 'Q', 'R', 'S', 'T', 'U', 'V', 'W', 'X', 'Y' ]

update: (output, domEl) ->
  if !output.match(/Running = 1;/)
    @populateStatus(domEl, "timemachine not running")
    return

  percent = output.match(/\s+Percent = "?(\d(?:\.\d+)?)"?;/)

  if percent && percent[1]
    percent = parseInt(parseFloat(percent[1]) * 100 / 2)
    @populatePercentage(domEl, @alphabet[percent])
  else
    @populateStatus(domEl, "preparing backup")

populateStatus: (domEl, html) ->
  $(domEl).find('.status').html(html)
  $(domEl).find('.percentage').html('')

populatePercentage: (domEl, html) ->
  $(domEl).find('.percentage').html(html)
  $(domEl).find('.status').html('')
