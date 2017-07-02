::  Bot for talk.

/-  talk
!:

|%
++  move  {bone card}
++  card
  $%  {$peer wire {@p term} path}
      {$pull wire {@p term} $~}
      {$poke wire {@p term} pod}
  ==
++  pod
  $%  {$talk-command command:talk}
      {$noun *}
  ==
++  action
  $%  {$join s/station:talk}
      {$leave s/station:talk}
      {$joined $~}
      {$subscribe $~}
      {$unsubscribe $~}
  ==
--

|_  {bowl joined/(list station:talk) available/?}
:: ++  prep  _`.  :: wipe state when app code is changed
++  poke-noun
  |=  a/action
  ^-  {(list move) _+>.$}
  ?-  a
  {$join *}
    ?^  (find [s.a ~] joined)
      ~&  [%already-joined s.a]
      [~ +>.$]
    ~&  [%joining s.a]
    :-  [[ost %peer /listen/(scot %p p.s.a)/[q.s.a] [p.s.a %talk] /afx/[q.s.a]/(scot %da now)] ~]
    +>.$(joined [s.a joined])
  {$leave *}
    =+  i=(find [s.a ~] joined)
    ?~  i
      ~&  [%already-left s.a]
      [~ +>.$]
    ~&  [%leaving s.a]
    :-  [[ost %pull /listen/(scot %p p.s.a)/[q.s.a] [p.s.a %talk] ~] ~]
    +>.$(joined (weld (scag u.i joined) (slag +(u.i) joined)))
  {$joined $~}
    ~&  [%currently-joined joined]
    [~ +>.$]
  {$subscribe $~}
    ?.  available
      ~&  [%already available=available]
      [~ +>.$]
    :_  +>.$(available |)
    [[ost %peer /subscribe [our %uptime] /uptime/report] ~]
  {$unsubscribe $~}
    ?:  available
      ~&  [%already available=available]
      [~ +>.$]
    :_  +>.$(available &)
    [[ost %pull /subscribe [our %uptime] ~] ~]
  ==

++  diff-talk-report
  |=  {wir/wire rep/report:talk}
  ^-  {(list move) _+>.$}
  ?+  rep
    ~&  [%unprocessed-report-type -:rep]
    [~ +>.$]
  {$grams *}  ::  Message list.
    :_  +>.$
    %+  murn  q.rep
      |=  gram/telegram:talk
      (read-telegram wir gram)
  ==

++  read-telegram
  |=  {wir/wire gram/telegram:talk}
  ^-  (unit move)
  =+  aud=(station-from-wire wir)
  ?~  aud
    ~&  %message-source-unclear
    ~
  =*  msg  r.r.q.gram
  ?+  msg
    ~&  [%unprocessed-message-type -:msg]
    ~
  {$lin *}  ::  Regular message.
    =+  tmsg=(trip q.msg)
    ?.  =((find (weld (cite our) " uptime") tmsg) [~ 0])
      ~
    :-  ~
    ::(send u.aud (weld "you said: " tmsg))
    [ost %poke /sending [our %uptime] %noun [%state ~]]
  ==

++  send
  |=  {aud/station:talk mess/?(tape @t)}
  ^-  move
  =+  mes=?@(mess (trip mess) mess)
  :*  ost
      %poke
      /repeat/(scot %ud 1)/(scot %p p.aud)/[q.aud]
      [our %talk]
      (said our aud %talk now eny [%leaf (weld ":: " mes)]~)
  ==

++  said  ::  Modified from lib/talk.hoon.
  |=  {our/@p cuz/station:talk dap/term now/@da eny/@uvJ mes/(list tank)}
  :-  %talk-command
  ^-  command:talk
  :-  %publish
  |-  ^-  (list thought:talk)
  ?~  mes  ~
  :_  $(mes t.mes, eny (sham eny mes))
  ^-  thought:talk
  :+  (shaf %thot eny)
    [[[%& cuz] [*envelope:talk %pending]] ~ ~]
  [now *bouquet:talk [%lin & (crip ~(ram re i.mes))]]

++  station-from-wire
  |=  wir/wire
  ^-  (unit station:talk)
  ?:  ?=({$listen *} wir)
    $(wir t.wir)
  ?.  ?=({@tas @tas *} wir)
    ~
  =+  ship=(slaw %p i.wir)
  ?~  ship
    ~&  [%unparsable-wire-station wir]
    ~
  =+  channel=(crip (slag 1 (spud t.wir)))
  [~ [u.ship channel]]

++  diff-noun
  |=  {wir/wire arg/*}
  ^-  {(list move) _+>.$}
  ~&  [%received-data arg]
  ?.  ?=(@dr arg)
    [~ +>.$]
  ?~  joined
    ~&  %not-joined
    [~ +>.$]
  :_  +>.$
  :_  ~
  (send [-.joined (weld "uptime: " (scow %dr arg))])

++  reap
  |=  {wir/wire error/(unit tang)}
  ^-  {(list move) _+>.$}
  ?~  error
    ~&  %successfully-subscribed
    [~ +>.$]
  ~&  [%subscription-failed error]
  [~ +>.$]
--
