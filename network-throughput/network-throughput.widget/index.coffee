network_interface = 'en1'

# Sample for one second, one time
# The command actually takes longer than 1 second to execute
command: "sar -n DEV 1 1 | grep #{network_interface} | tail -n1 | awk '{print $4,$6}'"

# Even though the command takes longer than 1 second to execute, 1000ms
# seems to work best (widget output updates approx every 3 seconds)
refreshFrequency: 1000

style: """
  bottom: 130px
  left: 10px
  color: #fff
  font-family: Helvetica

  &:after
    content: 'network throughput'
    position: absolute
    left: 0
    top: -14px
    font-size: 10px

  > div
    border: 1px solid #fff
    font-size: 24px
    font-weight: 100
    width: 175px
    max-width: 175px
    position: relative
    overflow: hidden

  .speed
    padding: 4px 6px 4px 6px
    position: relative

  .label
    position: absolute
    top: 4px
    right: 4px
    font-size: 10px
    text-transform: uppercase

  .in, .out
    background: rgba(255, 255, 255, .2)

  .in
    border-bottom: 0

  .hidden
    display: none
"""

render: -> """
  <div class='in'>
    <div class='speed'>0.00 KB/s</div>
    <div class='label'>in</div>
  </div>
  <div class='out'>
    <div class='speed'>0.00 KB/s</div>
    <div class='label'>out</div>
  </div>
"""

renderBytes: (bytes) ->
  bytes = Number(bytes)
  threshold = 1000

  if bytes < threshold
    units = ['B']
    u = 0
  else
    units = ['kB','MB','GB','TB','PB','EB','ZB','YB']
    u = -1
    until bytes <= threshold
      bytes /= threshold
      ++u

  "#{bytes.toFixed(1)} #{units[u]}/s"


update: (output, domEl) ->
  [incoming, outgoing] = output.split(' ')

  $(domEl).find('.in .speed').html(@renderBytes(incoming))
  $(domEl).find('.out .speed').html(@renderBytes(outgoing))
