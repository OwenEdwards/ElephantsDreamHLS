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
* Some of the video and audio .m3u8 files have their #EXT-X-TARGETDURATION value set to 6 and some to 8. This inconsistency fails validation, although it still seems to play okay. The root cause of this (the way that ffmpeg works) needs addressing
* The different source media (.avi, .mov and .wav files) are slightly different lengths, which causes validation errors between the video streams and the audio streams.
* The WebVTT (.vtt) files are not split up into time segments, they are just included as a single long .vtt file. This does not seem to cause problems, but it may need fixing (although note that the [sample m3u8 url with captions](http://cdnbakmi.kaltura.com/p/243342/sp/24334200/playManifest/entryId/0_uka1msg4/flavorIds/1_vqhfu6uy,1_80sohj7p/format/applehttp/protocol/http/a.m3u8) linked at [Kaltura's WebVTT and HLS Captions Support page](https://knowledge.kaltura.com/webvtt-and-hls-captions-support) uses this same method of including WebVTT files)
* The audio description text (.vtt) track is marked in the master playlist file as having "public.accessibility.describes-video" CHARACTERISTICS. This value is not valid for a SUBTITLES track (only for an AUDIO track), and causes a validation violation, but there is no valid way to mark a text track as the equivalent of HTML kind="descriptions" in HLS.
