# ElephantsDreamHLS

Script and manifest files to create an HLS program containing the Elephants Dream video with captions, subtitles, and audio description.

Works on macOS with iTerm2 shell.

## To build the files

Run:

```
ed.sh
```

To clean up all created files, run:

```
clean.sh
```

## Prerequisites

The following tools are needed (some using Homebrew):

```
bash
wget
ffmpeg
sed
cat
```

And from Apple:

```
mediasubtitlesegmenter
mediastreamvalidator
hlsreport.py
```


## TODO

* Meet the Apple [HLS Authoring Specification for Apple Devices](https://developer.apple.com/documentation/http_live_streaming/hls_authoring_specification_for_apple_devices)
* The audio description text (.vtt) track is marked in the master playlist file as having "public.accessibility.describes-video" CHARACTERISTICS. This value is not valid for a SUBTITLES track (only for an AUDIO track), and causes a validation violation, but there is no valid way to mark a text track as the equivalent of HTML kind="descriptions" in HLS.
