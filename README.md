# urbit-uptime
Uptime monitor for urbit

## Operations
### Reset
Reset to current time

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
[%started ~.~2017.6.30..16.59.07..2588]
[%now ~2017.6.30..23.04.10..4640]
[%delta ~.~h6.m5.s3..20b8]
```
