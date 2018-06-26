# ElephantsDreamHLS

Script and manifest files to create an HLS program containing the Elephants Dream video with captions, subtitles, and audio description.

Works on macOS with iTerm2 shell.

## To build the files

Run:

```
> ed.sh
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

And optionally (from Apple):

```
mediastreamvalidator
hlsreport.py
```

to run a report on the HLS program when it is finished.

## TODO

* Some of the video and audio .m3u8 files have their #EXT-X-TARGETDURATION value set to 10, some to 11 and some to 12. All of those .m3u8 files are included in this repo with #EXT-X-TARGETDURATION set to 12, which passes validation, but the root cause of this (the way that ffmpeg works) needs addressing
* The WebVTT (.vtt) files are not split up into time segments, they are just included as a single long .vtt file. This does not seem to cause problems, but it may need fixing
* The audio description text (.vtt) track is marked in the master playlist file as having "public.accessibility.describes-video" CHARACTERISTICS. This value is not valid for a SUBTITLES track (only for an AUDIO track), and causes a validation violation, but there is no valid way to mark a text track as the equivalent of HTML kind="descriptions" in HLS.
