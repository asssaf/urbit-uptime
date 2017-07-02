:: Uptime monitor
!:
|%
++  move  {bone card}
++  card
  $%  {$wait wire @da}
      {$poke wire {@p term} {$noun action}}
  ==
++  action
  $%  {$state $~}
      {$reset to/@}
      {$enable $~}
      {$disable $~}
  ==
--
|_  {hid/bowl start/@da last/@da enabled/_|}
++  prep  _`.  :: wipe state when app code is changed
::
++  poke-urbit
  |=  to/@p
  ^-  {(list move) _+>.$}
  [[[ost.hid %poke /sending [to dap.hid] %noun [%state ~]] ~] +>.$]
::
++  coup
  |=  {wir/wire ack/(unit tang)}
  ?^  ack  (mean u.ack)
  ~&  %noun-acknowledged
  [~ +>.$]
::
++  poke-noun
  |=  b/*
  ^-  {(list move) _+>.$}
  ?>  (team our.hid src.hid)      :: don't allow strangers
  ?>  ?=(action b)
  =+  ^-  a/action  b
  ~|  [%poked-with a]
  ?-  a
  {$state $~}
    ~&  [%enabled enabled]
    ~&  [%started (scot %da start)]
    ~&  [%now now.hid]
    ~&  [%delta (scot %dr (sub now.hid start))]
    [~ +>.$]
  {$reset $~}
    (reset now.hid)
  {$reset @}
    (reset to.a)
  {$enable $~}
    (set &)
  {$disable $~}
    (set |)
  ==
++  reset
  |=  to/@da
  ^-  {(list move) _+>.$}
  ~&  [%reset to=(scot %da to)]
  [~ +>.$(start to)]
::
++  set
  |=  to/@f
  ^-  {(list move) _+>.$}
  ?:  =(to enabled)
    ~&  [%already enabled=enabled]
    [~ +>.$]
  ~&  [%setting enabled=to]
  ?.  to
    [~ +>.$(enabled to)]
  :_  +>.$(enabled to, last now.hid, start now.hid)
  [ost.hid %wait /timer (add ~s10 now.hid)]~
::
++  wake-timer
  |=  {wir/wire $~}  ^-  (quip move +>)
  :: ~|  [%woke (scot %dr (sub now.hid last))]
  ?.  enabled
    :: ~&  %ignoring-disabled
    [~ +>.$]
  :-  [ost.hid %wait /timer (add ~s10 now.hid)]~
  ?:  (gte now.hid (add last ~s20))
    +>.$(last now.hid, start now.hid)
  +>.$(last now.hid)
--
