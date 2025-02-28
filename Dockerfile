# Use a lightweight Android emulator image with noVNC support
FROM butomo1989/docker-android-x86-8.1

# Switch to root to install additional utilities
USER root

# Update and install required packages (curl and Python for the keep-alive HTTP server)
RUN apt-get update && apt-get install -y curl python3 && rm -rf /var/lib/apt/lists/*

# Remove the APK install step from build stage.
# Instead, we’ll do this at runtime once the emulator is running.

# Copy the startup script into the container
COPY keep_alive.sh /keep_alive.sh
RUN chmod +x /keep_alive.sh

# Expose the ports:
# 6080 for noVNC (remote GUI access)
# 8080 for a simple HTTP server to keep the container alive
EXPOSE 6080 8080

# Set the entrypoint to our startup script
CMD ["/keep_alive.sh"]
