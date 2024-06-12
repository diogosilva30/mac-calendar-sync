# Calendar Sync Outlook > ICloud Calendar

This repository contains an AppleScript that will sync
events from an Apple Exchange Calendar to an ICloud Calendar so
it can be shared in an ICal URL.

To execute once:

```shell
osascript Exchange_Sync.applescript
```

To execute periodically (e.g. every 1 hour):

```shell
# Put this in your crontab with "crontab -e"
0 * * * * osascript /your/path/mac-calendar-sync/Exchange_Sync.applescript > /your/path/mac-calendar-sync/cronjob.log
# If you don't want log files
0 * * * * osascript /your/path/mac-calendar-sync/Exchange_Sync.applescript > /dev/null 2>&1
```

## Credits

Code originally from [this gist](https://gist.github.com/MyKEms/3287c65f097a29b1756f3799842165bb)