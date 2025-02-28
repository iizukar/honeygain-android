#!/bin/bash
# Start a simple HTTP server on port 8080 for keep-alive
python3 -m http.server 8080 &

# Start the virtual framebuffer (Xvfb) on display :0
Xvfb :0 -screen 0 1024x768x16 &

# Launch a minimal window manager (fluxbox)
fluxbox &

# Start x11vnc to expose the X display (using default port 5900)
x11vnc -display :0 -nopw -forever &

# Launch noVNC (adjust the path as needed)
/opt/novnc/utils/launch.sh --vnc localhost:5900 &

# (Optional) Start your Android runtime session here (e.g., anbox session-manager)
# anbox session-manager --config /path/to/config.json &

# Optionally wait until the Android runtime is fully booted, then install/launch Honeygain
# adb shell monkey -p com.honeygain -c android.intent.category.LAUNCHER 1

# Keep the container alive
tail -f /dev/null
