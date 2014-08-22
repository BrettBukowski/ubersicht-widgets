command: "cat /Library/Backblaze.bzpkg/bzdata/bzreports/bzstat_remainingbackup.xml | grep remaining"

refreshFrequency: 2000

style: """
  top: 50%
  left: 2%
  color: #fff
  font-family: Futura
  font-size: 35pt
  line-height: 26pt

  .label
    font-size: 12pt
    display: block

  .hide
    display: none

"""

render: () -> """
  <span class='label'>backblaze status</span>
  <span class='files'></span>
  <span class='mb'></span>
  <span class='finished hide'>-</span>
"""

update: (output, domEl) ->
  finishedEl = $(domEl).find('.finished')
  filesEl = $(domEl).find('.files')
  bytesEl = $(domEl).find('.mb')

  files = output.match(/remainingnumfilesforbackup="(\d+)"/)
  if files
    files = parseInt(files[1], 10)
    filesEl.html(files + ' files').removeClass('hide')

  bytes = output.match(/remainingnumbytesforbackup="(\d+)"/)
  if bytes
    bytes = parseInt(bytes[1] / 1048576, 10)
    bytesEl.html(bytes + ' mb').removeClass('hide')

  if !files && !bytes
    finishedEl.removeClass('hide')
    filesEl.addClass('hide')
    bytesEl.addClass('hide')
  else
    finishedEl.addClass('hide')
