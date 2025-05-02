#!/bin/bash

INPUT_FILE="streams.txt"
FAILED_FILE="failed_downloads.txt"

rm -f "$FAILED_FILE"

success_count=0
fail_count=0

while IFS= read -r line; do
    # Skip empty or comment lines
    [[ -z "$line" || "$line" =~ ^# ]] && continue

    url=$(echo "$line" | awk '{print $1}')
    filepath=$(echo "$line" | awk '{print $2}')

    filename=$(basename "$filepath")
    folder=$(dirname "$filepath")

    mkdir -p "$folder"
    echo "🔊 Downloading: $filename"

    ffmpeg \
        -loglevel error \
        -user_agent "Mozilla/5.0" \
        -referer "$url" \
        -i "$url" \
        -vn -acodec libmp3lame -q:a 2 \
        "$filepath" -y < /dev/null

    if [[ $? -ne 0 ]]; then
        echo "❌ Failed: $filename"
        echo "$line" >> "$FAILED_FILE"
        ((fail_count++))
    else
        echo "✅ Success: $filename"
        ((success_count++))
    fi

    echo "--------------------------------------"
done < "$INPUT_FILE"

echo "🎉 Done! $success_count succeeded, $fail_count failed."
[[ $fail_count -gt 0 ]] && echo "📝 See $FAILED_FILE for details."
