FROM ubuntu:latest

# Install Xfce, VNC server, and websockify
RUN apt-get update && apt-get install -y xfce4 xfce4-goodies tightvncserver websockify

# Set a custom password for the VNC server
RUN mkdir /root/.vnc && echo "7295123@yu" | vncpasswd -f > /root/.vnc/passwd && chmod 600 /root/.vnc/passwd

# Expose the VNC server port and the websockify port
EXPOSE 5901 6080

# Start the VNC server and websockify
CMD ["sh", "-c", "vncserver :1 -depth 24 -geometry 1024x768 && websockify -D --web=/usr/share/novnc/ --cert=/etc/ssl/certs/ssl-cert-snakeoil.pem --key=/etc/ssl/private/ssl-cert-snakeoil.key 6080 localhost:5901"]
