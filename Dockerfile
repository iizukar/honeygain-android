# Use a lightweight Android emulator image that includes noVNC
FROM butomo1989/docker-android-x86-8.1

# Switch to root to install extra utilities
USER root

# Install curl and Python (if not already present)
RUN apt-get update && apt-get install -y curl python3

# Download the Honeygain APK (the URL you provided)
RUN curl -L "https://download.honeygain.com/android-app/download1/honeygain_app.apk?_gl=1*1j93mn0*_gcl_au*MjEzMDU3Mzk4NS4xNzQwNjg5NTkyLjE4NzgwNTk1MzIuMTc0MDY5MzY2OS4xNzQwNjkzNjY5*_ga*MTA2MTExOTA3MC4xNzQwNjg5NTky*_ga_3LNFBDTH6H*MTc0MDczNzYwMi4yLjEuMTc0MDc1ODg4MC4wLjAuMA.." -o /tmp/honeygain.apk

# Install the APK on the emulator via adb
RUN adb install /tmp/honeygain.apk

# Expose ports: 6080 for noVNC and 8080 for the dummy keep-alive web server
EXPOSE 6080 8080

# Copy the startup script (see below)
COPY keep_alive.sh /keep_alive.sh
RUN chmod +x /keep_alive.sh

# Use the custom startup script as the container command
CMD ["/keep_alive.sh"]
