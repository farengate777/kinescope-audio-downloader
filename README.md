# Kinescope Audio Downloader

This is a simple shell script to batch-download **audio** from Kinescope-hosted `.mpd` streams using `ffmpeg`. Should probably work for other `.mpd` streams.

## Features

- Downloads **only audio** from `.mpd` stream URLs
- Saves as `.mp3` using `ffmpeg` (high quality)
- Lets you control **output paths and filenames**
- Logs failed downloads to `failed_downloads.txt` for retrying
- Cross-platform: works on macOS and Linux

## Project Structure
```
├── download_kinescope_audio.sh      # Main download script
├── streams.txt                      # List of pairs
├── streams.txt.template             # Starter example
├── failed_downloads.txt             # Auto-generated log of failures
└── .gitignore
```

## Requirements

- [`ffmpeg`](https://ffmpeg.org/)

Install on macOS:

```bash
brew install ffmpeg
```

Or on Ubuntu/Debian:
```
sudo apt install ffmpeg
```

## Format of streams.txt

Each line:
```
<mpd_url> <output_path/filename.mp3>
```
Examples:
```
https://kinescope.io/abc/master.mpd output/audio1.mp3
https://kinescope.io/xyz/master.mpd ./downloads/xyz_clip.mp3
```
💡 You can use relative or absolute paths for the filenames.

## How to use
1. Copy streams.txt.template to streams.txt and fill it in:
```
cp streams.txt.template streams.txt
```
3. Make the script executable:
```
chmod +x download_kinescope_audio.sh
```
4. Run the script:
```
./download_kinescope_audio.sh
```
5. Review any failures (if needed):
```
cat failed_downloads.txt
```
To retry them:
```
mv failed_downloads.txt streams.txt
./download_kinescope_audio.sh
```

## Controls
Press q inside ffmpeg to cancel the current download

Press Ctrl + C to stop the script entirely

## License

MIT — use freely, no warranties, don’t blame me, blame ChatGPT :D 
