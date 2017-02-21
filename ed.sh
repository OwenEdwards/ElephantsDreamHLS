#!/bin/bash

# This seems to be the highest quality and resolution version of the
#  Elephants Dream video on the Archive.org site:
#    Encoder: AVI-Mux GUI 1.17.5, Apr  5 2006  18:41:17
#    Duration: 00:10:53.79, start: 0.000000, bitrate: 10456 kb/s
#    Video: msmpeg4v2 (MP42 / 0x3234504D), yuv420p, 1920x1080, 10002 kb/s, 24 fps, 24 tbr, 24 tbn, 24 tbc
#    Audio: AC3 format, 48000 Hz, 5.1 channels, fltp, 448 kb/s

#wget http://archive.org/download/ElephantsDream/ed_hd.avi

# Video:
#
#         Stream ,              Video            ,        Audio
# gear5: 2048kbps, 1920x1080, Main, 4.0, 1920kbps, AAC-LC, Stereo, 128kbps
# gear4: 1024kbps,  1280x720, Main, 3.1,  896kbps, AAC-LC, Stereo, 128kbps
# gear3:  512kbps,   960x540, Main, 3.1,  448kbps, AAC-LC, Stereo,  64kbps
# gear2:  512kbps,   640x360, Main, 3.0,  448kbps, AAC-LC, Stereo,  64kbps
# gear1:  256kbps,   480x270, Main, 1.3,  192kbps, AAC-LC, Stereo,  64kbps
# gear0:   64kbps,         -,    -,   -,        -, AAC-LC, Stereo,  64kbps
#
# Description audio track:
#
# AAC-LC, Stereo, 128kbps
# AAC-LC, Stereo,  64kbps
#

mkdir ed_hls_gear5
cd    ed_hls_gear5
ffmpeg -i ~/Downloads/ed_hd.avi -n -s 1920x1080 -vcodec h264 -g 48 -x264-params frame=key_frame:no-scenecut -profile:v main -level 4.0 -b:v 1920k -b:a 128k -ac 2 -acodec aac -ar 48000 -start_number 0 -hls_time 10 -hls_list_size 0 -f hls index.m3u8
cd    ..

mkdir ed_hls_gear4
cd    ed_hls_gear4
ffmpeg -i ~/Downloads/ed_hd.avi -n -s 1280x720 -vcodec  h264 -g 48 -x264-params frame=key_frame:no-scenecut -profile:v main -level 3.1 -b:v 896k -b:a 128k -ac 2 -acodec aac -ar 48000 -start_number 0 -hls_time 10 -hls_list_size 0 -f hls index.m3u8
cd    ..

mkdir ed_hls_gear3
cd    ed_hls_gear3
ffmpeg -i ~/Downloads/ed_hd.avi -n -s 960x540 -vcodec  h264 -g 48 -x264-params frame=key_frame:no-scenecut -profile:v main -level 3.1 -b:v 448k -b:a 64k -ac 2 -acodec aac -ar 48000 -start_number 0 -hls_time 10 -hls_list_size 0 -f hls index.m3u8
cd    ..

mkdir ed_hls_gear2
cd    ed_hls_gear2
ffmpeg -i ~/Downloads/ed_hd.avi -n -s 640x360 -vcodec  h264 -g 48 -x264-params frame=key_frame:no-scenecut -profile:v main -level 3.0 -b:v 448k -b:a 64k -ac 2 -acodec aac -ar 48000 -start_number 0 -hls_time 10 -hls_list_size 0 -f hls index.m3u8
cd    ..

mkdir ed_hls_gear1
cd    ed_hls_gear1
ffmpeg -i ~/Downloads/ed_hd.avi -n -s 480x270 -vcodec  h264 -g 48 -x264-params frame=key_frame:no-scenecut -profile:v main -level 1.3 -b:v 192k -b:a 64k -ac 2 -acodec aac -ar 48000 -start_number 0 -hls_time 10 -hls_list_size 0 -f hls index.m3u8
cd    ..

mkdir ed_hls_gear0
cd    ed_hls_gear0
ffmpeg -i ~/Downloads/ed_hd.avi -n -vn -b:a 64k -ac 2 -acodec aac -ar 48000 -start_number 0 -hls_time 10 -hls_list_size 0 -f hls index.m3u8
cd    ..

mkdir ed_hls_adesc1
cd    ed_hls_adesc1
ffmpeg -i ~/Dropbox/Elephants\ Dream/Elephants\ Dream\ final.mov -n -vn -b:a 64k -ac 2 -acodec aac -ar 48000 -start_number 0 -hls_time 10 -hls_list_size 0 -f hls index.m3u8
cd    ..

mkdir ed_hls_adesc0
cd    ed_hls_adesc0
ffmpeg -i ~/Dropbox/Elephants\ Dream/Elephants\ Dream\ final.mov -n -vn -b:a 128k -ac 2 -acodec aac -ar 48000 -start_number 0 -hls_time 10 -hls_list_size 0 -f hls index.m3u8
cd    ..
