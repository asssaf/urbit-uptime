# urbit-uptime
Uptime monitor for urbit

## How Does It Work?
This is not a real uptime daemon (i.e. reading uptime from the kernel). It stores a start timestamp and calculates the time passed since then. The start time can be updated in one of two ways:
1. Manually, by using the reset command
2. Using a heartbeat timer, see the enable command for details

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
[%since ~.~2017.6.30..16.59.07..2588]
[%now ~2017.6.30..23.04.10..4640]
[%delta ~.~h6.m5.s3..20b8]
```

### Enable
Enable the uptime timer which wakes up every 10 seconds and checks the time passed since the last poll. In case more than 20 seconds passed, the uptime is reset.

Note that if the urbit went down and came back up in less than 20 seconds, the uptime will not be reset.

Also the timer is not guaranteed to fire at the requested time so this is not guaranteed to be correct.

### Disable
Disable the uptime timer.

## Web Interface
Uptime is exposed through the web interface at https://yourship.urbit.org/uptime

## mytalkbot Extension
A modified talkbot based on the example in [urbit by doing](https://github.com/Fang-/Urbit-By-Doing) is provided (in `app/mytalkboot.hoon`. It can be used to query the current uptime through a talk channel.

### Usage
#### Enable
1. Start the bot on the same ship as the uptime app
```
|start mytalkbot
```
2. Join a channel
```
:mytalkbot [%join our ~.sandbox]
```
3. Subscribe to uptime reports
```
:mytalkbot [%subscribe ~]
```
4. Ask for an update through talk:
```
> ~ship_name uptime
~ship_name= :: uptime is ~m10.s2..112d
```
#### Disable
1. Unsubscribe from uptime reports
```
:mytalkbot [%unsubscribe ~]
```
2. Leave the channel
```
:mytalkbot [%leave our ~.sandbox]
```
