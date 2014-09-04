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
    background: rgba(255, 255, 255, .2)
    border: 1px solid #fff
    font-size: 24px
    font-weight: 100
    width: 175px
    max-width: 175px
    position: relative
    overflow: hidden

  .speed
    padding: 4px 6px
    position: relative

  .label
    position: absolute
    top: 4px
    right: 4px
    font-size: 10px
    text-transform: uppercase

  .in
    border-bottom: 0
"""

render: -> """
  <div class='in'>
    <div class='speed'>0.0 kB/s</div>
    <div class='label'>in</div>
  </div>
  <div class='out'>
    <div class='speed'>0.0 kB/s</div>
    <div class='label'>out</div>
  </div>
"""

units: ['B','kB','MB','GB','TB','PB','EB','ZB','YB']

renderBytes: (bytes) ->
  bytes = Number(bytes)
  threshold = 1000
  unit = 0

  until bytes <= threshold
    bytes /= threshold
    unit++

  "#{bytes.toFixed(1)} #{@units[unit]}/s"

update: (output, domEl) ->
  [incoming, outgoing] = output.split(' ')

  $(domEl).find('.in .speed').html(@renderBytes(incoming))
  $(domEl).find('.out .speed').html(@renderBytes(outgoing))
