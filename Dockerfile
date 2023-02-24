FROM ubuntu:latest

# Set the keyboard configuration option to 77 (Portuguese (Brazil))
RUN echo 'debconf debconf/frontend select Noninteractive' | debconf-set-selections
RUN echo 'keyboard-configuration keyboard-configuration/layout select Portuguese (Brazil)' | debconf-set-selections
RUN echo 'keyboard-configuration keyboard-configuration/layoutcode select br' | debconf-set-selections
RUN echo 'keyboard-configuration keyboard-configuration/model select Generic 105-key (Intl) PC' | debconf-set-selections
RUN echo 'keyboard-configuration keyboard-configuration/options select ' | debconf-set-selections
RUN echo 'keyboard-configuration keyboard-configuration/toggle select No toggling' | debconf-set-selections

# Set the timezone (optional)
RUN ln -sf /usr/share/zoneinfo/America/Sao_Paulo /etc/localtime

# Install Xfce, VNC server, and websockify
RUN apt-get update && apt-get install -y xfce4 xfce4-goodies tightvncserver websockify

ENV USER=root

# Set a custom password for the VNC server
RUN mkdir /root/.vnc && echo "7295123@yu" | vncpasswd -f > /root/.vnc/passwd && chmod 600 /root/.vnc/passwd

# Expose the VNC server port and the websockify port
EXPOSE 5901 6080

# Start the VNC server and websockify
CMD ["sh", "-c", "vncserver :4 -depth 24 -geometry 1024x768 && websockify -D --web=/usr/share/novnc/ --cert=/etc/ssl/certs/ssl-cert-snakeoil.pem --key=/etc/ssl/private/ssl-cert-snakeoil.key 6080 localhost:5901"]
