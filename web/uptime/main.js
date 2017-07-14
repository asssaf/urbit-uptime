$(function() {
  var since, $go, $uptime, $since, $err

  $go     = $('#go')
  $uptime = $('#uptime')
  $since  = $('#since')
  $err    = $('#err')

  $go.on("click",
    function() {
      window.urb.send(
        "request", {mark: "uptime-request"}
      ,function(err,res) {
        if(err)
          return $err.text("There was an error. Sorry!")
        if(res.data !== undefined &&
           res.data.ok !== undefined &&
           res.data.ok !== true)
          $err.text(res.data.res)
        else
          console.log("poke succeeded");
      })
  })

  window.urb.appl = "uptime"
  window.urb.bind('/uptime/response',
    function(err,dat) {
      since = dat.data.since
      $since.text(new Date(since))
      refreshUptime()
    }
  )

  function refreshUptime() {
    if (!since) {
      return
    }
    var now = new Date().getTime()
    var delta = now - since
    $uptime.text(formatDelta(delta))
  }

  function formatDelta(delta) {
    delta = Math.floor(delta/1000)
    var seconds = delta % 60
    delta = Math.floor(delta/60)
    var minutes = delta % 60
    delta = Math.floor(delta/60)
    var hours = delta % 60
    delta = Math.floor(delta/24)
    var days = delta

    return days + "d " + hours + "h " + minutes + "m " + seconds + "s"
  }

  function refreshLoop() {
    refreshUptime()
    setTimeout(refreshLoop, 1000)
  }

  refreshLoop()
})
