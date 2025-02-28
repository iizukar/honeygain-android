# Use a minimal Debian base image
FROM debian:bullseye-slim

# Install essential packages
RUN apt-get update && apt-get install -y \
    wget curl adb python3 \
    xvfb fluxbox x11vnc novnc \
    && rm -rf /var/lib/apt/lists/*

# (Optional) Install Anbox or a minimal Android runtime here.
# For example, if a prebuilt minimal Android runtime archive exists:
# RUN wget -O /tmp/minimal-android.tar.gz "http://example.com/minimal-android.tar.gz" \
#     && tar -xzf /tmp/minimal-android.tar.gz -C /opt/android \
#     && rm /tmp/minimal-android.tar.gz

# Download the Honeygain APK
RUN wget -O /tmp/honeygain.apk "https://download.honeygain.com/android-app/download1/honeygain_app.apk?_gl=1*1j93mn0*_gcl_au*MjEzMDU3Mzk4NS4xNzQwNjg5NTkyLjE4NzgwNTk1MzIuMTc0MDY5MzY2OS4xNzQwNjkzNjY5*_ga*MTA2MTExOTA3MC4xNzQwNjg5NTky*_ga_3LNFBDTH6H*MTc0MDczNzYwMi4yLjEuMTc0MDc1ODg4MC4wLjAuMA.."

# Install the APK using adb (assuming the runtime supports it)
RUN adb install /tmp/honeygain.apk

# Expose ports: 6080 for noVNC, 8080 for the keep-alive HTTP server
EXPOSE 6080 8080

# Copy in our startup script
COPY start.sh /start.sh
RUN chmod +x /start.sh

# Set the container entrypoint
CMD ["/start.sh"]
