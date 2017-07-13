$(function() {
  var uptime, $go, $uptime, $err

  $go     = $('#go')
  $uptime = $('#uptime')
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
      uptime = dat.data.uptime
      $uptime.text(uptime)
    }
  )
})
