#! /bin/bash

# Add metadata to variables.
NAME=$(curl -H "Metadata-Flavor: Google" "http://metadata.google.internal/computeMetadata/v1/instance/name")
HOSTNAME=$(curl -H "Metadata-Flavor: Google" "http://metadata.google.internal/computeMetadata/v1/instance/hostname")
MACHINE_TYPE=$(curl -H "Metadata-Flavor: Google" "http://metadata.google.internal/computeMetadata/v1/instance/machine-type")
IMAGE=$(curl -H "Metadata-Flavor: Google" "http://metadata.google.internal/computeMetadata/v1/instance/image")
ZONE=$(curl -H "Metadata-Flavor: Google" "http://metadata.google.internal/computeMetadata/v1/instance/zone")
INTERNAL_IP=$(curl -H "Metadata-Flavor: Google" "http://metadata.google.internal/computeMetadata/v1/instance/network-interfaces/0/ip")
EXTERNAL_IP=$(curl -H "Metadata-Flavor: Google" "http://metadata.google.internal/computeMetadata/v1/instance/network-interfaces/0/access-configs/0/external-ip")
TAGS=$(curl -H "Metadata-Flavor: Google" "http://metadata.google.internal/computeMetadata/v1/instance/tags")

# Install the Apache HTTP Server.
apt update
apt install -y apache2

# Create the custom index.html file.
cat << EOF > /var/www/html/index.html
<body style="font-family: monospace, monospace">
<html>
  <body>
    <p><b>Name:</b> $NAME</p>
    <p><b>Hostname:</b> $HOSTNAME</p>
    <p><b>Machine type:</b> $MACHINE_TYPE</p>
    <p><b>Image:</b> $IMAGE</p>
    <p><b>Zone:</b> $ZONE</p>
    <p><b>Internal IP:</b> $INTERNAL_IP</p>
    <p><b>External IP:</b> $EXTERNAL_IP</p>
    <p><b>Tags:</b> $TAGS</p>
  </body>
</html>
EOF