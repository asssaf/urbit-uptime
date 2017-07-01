# urbit-uptime
Uptime monitor for urbit

## Operations
### Manual Reset
Reset uptime to 0 (time since now)

```
> :uptime [%reset ~]
```

Reset to a specified time

```
> :uptime [%reset (sub now ~h5.m30)]
```

### State
Get the current uptime:
```
> :uptime [%state ~]
>=
[%enabled %.y]
[%started ~.~2017.6.30..16.59.07..2588]
[%now ~2017.6.30..23.04.10..4640]
[%delta ~.~h6.m5.s3..20b8]
```

### Enable
Enable the uptime timer which wakes up every 10 seconds and checks the time passed since the last poll. In case more than 20 seconds passed, the uptime is reset.

Note that if the urbit went down and came back up in less than 20 seconds, the uptime will not be reset.

Also the timer is not guaranteed to fire at the requested time so this is not guaranteed to be correct.

### Disable
Disable the uptime timer.
