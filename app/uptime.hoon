:: Uptime monitor
!:
|%
++  action
  $%  {$state $~}
      {$reset to/@}
  ==
--
|_  {bowl start/@da}
++  prep  _`.  :: wipe state when app code is changed
::
++  poke-noun
  |=  a/action
  ^-  {(list move) _+>.$}
  ?-  a
  {$state $~}
    ~&  [%started (scot %da start)]
    ~&  [%now now]
    ~&  [%delta (scot %dr (sub now start))]
    [~ +>.$]
  {$reset $~}
    ~&  [%reset now]
    [~ +>.$(start now)]
  {$reset @}
    ~&  [%reset (scot %da to.a)]
    [~ +>.$(start to.a)]
  ==
--
