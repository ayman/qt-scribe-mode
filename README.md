qt-scribe
=========

Remote control the Quicktime Player and insert some data from the
current movie into the active buffer.

This is intended for doing transcription of videos inside of emacs.

To get started, load the file and invoke the mode like: `M-x
qt-scribe-mode`.

Produces a text file that you can `grep` for content in a human
readable format like:

```
[file: "subject1.mp4"]

[00:00:50.09] Participant deletes running apps.
[00:01:25.06] Queues podcast in playlist.
[00:01:40.06] Stops podcast.
[00:02:04.06] Sets alarm.
```

keybindings
-----------

* `C-c SPC` toggles the playback on and off
* `C-c RET` inserts a timestamp
* `C-c j` jump back a few seconds
* `C-c k` jump forward a few seconds

