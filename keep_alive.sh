#!/bin/bash
# Start a simple HTTP server on port 8080 to prevent idling
python3 -m http.server 8080 &

# Wait for the Android emulator to fully boot
echo "Waiting for Android emulator to boot..."
until adb shell getprop sys.boot_completed | grep -q "1"; do
    sleep 1
done
echo "Emulator booted."

# Launch the Honeygain app (replace com.honeygain with the actual package name if different)
adb shell monkey -p com.honeygain -c android.intent.category.LAUNCHER 1

# Keep the container running indefinitely (or you can tail a log file)
tail -f /dev/null
