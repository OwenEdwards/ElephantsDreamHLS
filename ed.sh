#!/bin/bash

# This seems to be the highest quality and resolution version of the
#  Elephants Dream video on the Archive.org site:
#    Encoder: AVI-Mux GUI 1.17.5, Apr  5 2006  18:41:17
#    Duration: 00:10:53.79, start: 0.000000, bitrate: 10456 kb/s
#    Video: msmpeg4v2 (MP42 / 0x3234504D), yuv420p, 1920x1080, 10002 kb/s, 24 fps, 24 tbr, 24 tbn, 24 tbc
#    Audio: AC3 format, 48000 Hz, 5.1 channels, fltp, 448 kb/s

if [ ! -f 'ed_hd.avi' ]; then
  wget 'http://archive.org/download/ElephantsDream/ed_hd.avi'
else
  echo "File 'ed_hd.avi' is already present"
fi

# Get the audio description parts

if [ ! -f 'Elephants Dream with Audio Description.mov' ]; then
  wget 'https://media.githubusercontent.com/media/OwenEdwards/ElephantsDreamAudioDescription/master/Elephants Dream with Audio Description.mov'
else
  echo "File 'Elephants Dream with Audio Description.mov' is already present"
fi
if [ ! -f 'Elephants Dream Audio Description.wav' ]; then
  wget 'https://media.githubusercontent.com/media/OwenEdwards/ElephantsDreamAudioDescription/master/Elephants Dream Audio Description.wav'
else
  echo "File 'Elephants Dream Audio Description.wav' is already present"
fi
if [ ! -f 'ed-description-jjhunt.webvtt' ]; then
  wget 'https://raw.githubusercontent.com/OwenEdwards/ElephantsDreamAudioDescription/master/ed-description-jjhunt.webvtt'
else
  echo "File 'ed-description-jjhunt.webvtt' is already present"
fi

echo ''

# Video:
#
# ***TOOO: Needs updating ***
#
#         Stream ,              Video            ,        Audio
# gear5: 2800kbps, 1920x1080, Main, 4.0, 1920kbps, AAC-LC, Stereo, 128kbps
# gear4: 1980kbps,  1280x720, Main, 3.1,  896kbps, AAC-LC, Stereo, 128kbps
# gear3: 1400kbps,   854x480, Main, 3.1,  448kbps, AAC-LC, Stereo,  64kbps
# gear2:  990kbps,   640x360, Main, 3.0,  448kbps, AAC-LC, Stereo,  64kbps
# gear1:  700kbps,   480x270, Main, 1.3,  192kbps, AAC-LC, Stereo,  64kbps
#
# Audio tracks:
#
# 1: AAC-LC, Stereo, 128kbps
# 0: AAC-LC, Stereo,  64kbps
#

# To try:
# (See https://docs.peer5.com/guides/production-ready-hls-vod/)
#
# ffmpeg -hide_banner -y -i ed_hd.avi \
#  -vf scale=w=640:h=360:force_original_aspect_ratio=decrease -c:a aac -ar 48000 -c:v h264 -profile:v main -crf 20 -sc_threshold 0 -g 48 -keyint_min 48 -hls_time 4 -hls_playlist_type vod  -b:v 800k -maxrate 856k -bufsize 1200k -b:a 96k -hls_segment_filename ed_hls/360p_%03d.ts ed_hls/360p.m3u8 \
#  -vf scale=w=854:h=480:force_original_aspect_ratio=decrease -c:a aac -ar 48000 -c:v h264 -profile:v main -crf 20 -sc_threshold 0 -g 48 -keyint_min 48 -hls_time 4 -hls_playlist_type vod -b:v 1400k -maxrate 1498k -bufsize 2100k -b:a 128k -hls_segment_filename ed_hls/480p_%03d.ts ed_hls/480p.m3u8 \
#  -vf scale=w=1280:h=720:force_original_aspect_ratio=decrease -c:a aac -ar 48000 -c:v h264 -profile:v main -crf 20 -sc_threshold 0 -g 48 -keyint_min 48 -hls_time 4 -hls_playlist_type vod -b:v 2800k -maxrate 2996k -bufsize 4200k -b:a 128k -hls_segment_filename ed_hls/720p_%03d.ts ed_hls/720p.m3u8 \
#  -vf scale=w=1920:h=1080:force_original_aspect_ratio=decrease -c:a aac -ar 48000 -c:v h264 -profile:v main -crf 20 -sc_threshold 0 -g 48 -keyint_min 48 -hls_time 4 -hls_playlist_type vod -b:v 5000k -maxrate 5350k -bufsize 7500k -b:a 192k -hls_segment_filename ed_hls/1080p_%03d.ts ed_hls/1080p.m3u8


mkdir -p ed_hls_gear5
if [ ! -f ed_hls_gear5/index0.ts ]; then
  ffmpeg -i ed_hd.avi -n -s 1920x1080 -vcodec h264 -preset slower -sc_threshold 0 -g 48 -x264-params keyint=48:min-keyint=24 -profile:v high -level 4.2 -b:v 6000k -an -start_number 0 -hls_time 5 -hls_list_size 0 -hls_playlist_type vod -hls_flags 'independent_segments' -f hls ed_hls_gear5/index.m3u8
fi

mkdir -p ed_hls_gear4
if [ ! -f ed_hls_gear4/index0.ts ]; then
  ffmpeg -i ed_hd.avi -n -s 1280x720 -vcodec h264 -preset slower -sc_threshold 0 -g 48 -x264-params keyint=48:min-keyint=24 -profile:v high -level 4.0 -b:v 3000k -an -start_number 0 -hls_time 5 -hls_list_size 0 -hls_playlist_type vod -hls_flags 'independent_segments' -f hls ed_hls_gear4/index.m3u8
fi

mkdir -p ed_hls_gear3
if [ ! -f ed_hls_gear3/index0.ts ]; then
  ffmpeg -i ed_hd.avi -n -s 854x480 -vcodec h264 -preset slower -sc_threshold 0 -g 48 -x264-params keyint=48:min-keyint=24 -profile:v main -level 4.0 -b:v 2000k -an -start_number 0 -hls_time 5 -hls_list_size 0 -hls_playlist_type vod -hls_flags 'independent_segments' -f hls ed_hls_gear3/index.m3u8
fi

mkdir -p ed_hls_gear2
if [ ! -f ed_hls_gear2/index0.ts ]; then
  ffmpeg -i ed_hd.avi -n -s 640x360 -vcodec h264 -preset slower -sc_threshold 0 -g 48 -x264-params keyint=48:min-keyint=24 -profile:v main -level 3.1 -b:v 1000k -an -start_number 0 -hls_time 5 -hls_list_size 0 -hls_playlist_type vod -hls_flags 'independent_segments' -f hls ed_hls_gear2/index.m3u8
fi

mkdir -p ed_hls_gear1
if [ ! -f ed_hls_gear1/index0.ts ]; then
  ffmpeg -i ed_hd.avi -n -s 480x270 -vcodec h264 -preset slower -sc_threshold 0 -g 48 -x264-params keyint=48:min-keyint=24 -profile:v main -level 3.0 -b:v 700k -an -start_number 0 -hls_time 5 -hls_list_size 0 -hls_playlist_type vod -hls_flags 'independent_segments' -f hls ed_hls_gear1/index.m3u8
fi

mkdir -p ed_hls_main_audio0
if [ ! -f ed_hls_main_audio0/index0.ts ]; then
  ffmpeg -i ed_hd.avi -n -vn -b:a 64k -ac 2 -acodec aac -ar 48000 -start_number 0 -hls_time 6 -hls_list_size 0 -hls_playlist_type vod -f hls ed_hls_main_audio0/index.m3u8
fi

mkdir -p ed_hls_main_audio1
if [ ! -f ed_hls_main_audio1/index0.ts ]; then
  ffmpeg -i ed_hd.avi -n -vn -b:a 128k -ac 2 -acodec aac -ar 48000 -start_number 0 -hls_time 6 -hls_list_size 0 -hls_playlist_type vod -f hls ed_hls_main_audio1/index.m3u8
fi

mkdir -p ed_hls_adesc0
if [ ! -f ed_hls_adesc0/index0.ts ]; then
  ffmpeg -i 'Elephants Dream with Audio Description.mov' -n -vn -b:a 64k -ac 2 -acodec aac -ar 48000 -start_number 0 -hls_time 6 -hls_list_size 0 -hls_playlist_type vod -f hls ed_hls_adesc0/index.m3u8
fi

mkdir -p ed_hls_adesc1
if [ ! -f ed_hls_adesc1/index0.ts ]; then
  ffmpeg -i 'Elephants Dream with Audio Description.mov' -n -vn -b:a 128k -ac 2 -acodec aac -ar 48000 -start_number 0 -hls_time 6 -hls_list_size 0 -hls_playlist_type vod -f hls ed_hls_adesc1/index.m3u8
fi

mkdir -p ed_hls_just_adesc0
if [ ! -f ed_hls_just_adesc0/index0.ts ]; then
  ffmpeg -i 'Elephants Dream Audio Description.wav' -n -vn -b:a 64k -ac 2 -acodec aac -ar 48000 -start_number 0 -hls_time 6 -hls_list_size 0 -hls_playlist_type vod -f hls ed_hls_just_adesc0/index.m3u8
fi

mkdir -p ed_hls_just_adesc1
if [ ! -f ed_hls_just_adesc1/index0.ts ]; then
  ffmpeg -i 'Elephants Dream Audio Description.wav' -n -vn -b:a 128k -ac 2 -acodec aac -ar 48000 -start_number 0 -hls_time 6 -hls_list_size 0 -hls_playlist_type vod -f hls ed_hls_just_adesc1/index.m3u8
fi

# Create the Description WebVTT file

mkdir -p ed_hls_webvtt

source='ed-description-jjhunt.webvtt'
file='descriptions.en.vtt'

if [ ! -f ed_hls_webvtt/$( basename $file .vtt )0.webvtt ]; then
  echo "Creating ${file} segments"
  mediasubtitlesegmenter -t 6 -f ed_hls_webvtt -i $( basename $file .vtt ).m3u8 -B $( basename $file .vtt ) -m 90000 -D 654 -l $( basename $file .vtt ).log ${source}
fi
# Create captions & subtitles WebVTT files from the video.js repo

captions='captions.en.vtt captions.ja.vtt captions.ar.vtt captions.ru.vtt captions.sv.vtt'

for file in $captions; do
  if [ ! -f $file ]; then
    wget https://raw.githubusercontent.com/videojs/video.js/master/docs/examples/elephantsdream/$file
  else
    echo "File '$file' is already present"
  fi

  source=${file}

  if [ ! -f ed_hls_webvtt/$( basename $file .vtt )0.webvtt ]; then
    echo "Creating ${file} segments"
    mediasubtitlesegmenter -t 6 -f ed_hls_webvtt -i $( basename $file .vtt ).m3u8 -B $( basename $file .vtt ) -m 90000 -D 654 -l $( basename $file .vtt ).log ${source}
  fi

done

echo ''

mediastreamvalidator -O . ed_hd.m3u8 && hlsreport.py -o ed_hd_validation_data.html validation_data.json
