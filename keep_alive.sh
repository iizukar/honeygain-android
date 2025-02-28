#!/bin/bash
# Start a simple HTTP server on port 8080 to prevent idling
python3 -m http.server 8080 &

# Wait for the Android emulator to finish booting
echo "Waiting for the Android emulator to boot..."
until [ "$(adb shell getprop sys.boot_completed 2>/dev/null)" = "1" ]; do
    sleep 1
done
echo "Emulator booted!"

# Download the Honeygain APK at runtime
echo "Downloading Honeygain APK..."
curl -L "https://download.honeygain.com/android-app/download1/honeygain_app.apk?_gl=1*1j93mn0*_gcl_au*MjEzMDU3Mzk4NS4xNzQwNjg5NTkyLjE4NzgwNTk1MzIuMTc0MDY5MzY2OS4xNzQwNjkzNjY5*_ga*MTA2MTExOTA3MC4xNzQwNjg5NTky*_ga_3LNFBDTH6H*MTc0MDczNzYwMi4yLjEuMTc0MDc1ODg4MC4wLjAuMA.." -o /tmp/honeygain.apk

# Install the Honeygain APK (ensure that the package name below matches the app's actual package name)
echo "Installing Honeygain APK..."
adb install /tmp/honeygain.apk

# Launch the Honeygain app using adb. Replace 'com.honeygain' with the correct package name if necessary.
echo "Launching Honeygain app..."
adb shell monkey -p com.honeygain -c android.intent.category.LAUNCHER 1

# Keep the container running
tail -f /dev/null
