;html
  ;head
    ;script(type "text/javascript", src "//cdnjs.cloudflare.com/ajax/libs/jquery/2.1.1/jquery.min.js");
    ;script(type "text/javascript", src "/~/at/lib/js/urb.js");
    ;title: Uptime
  ==
  ;body
    ;div#cont
      ;table
        ;tr
          ;th: Uptime:
          ;td#uptime: <updating...>
        ==
        ;tr
          ;th: Since:
          ;td#since: <updating...>
        ==
      ==
      ;input#go(type "button", value "Refresh");
      ;div#err(class "disabled");
    ==
    ;script(type "text/javascript", src "/uptime/main.js");
  ==
==
