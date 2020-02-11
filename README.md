# Docker BB

Used mainly to access [BB](www.bb.com.br), run the following command:

    docker run \
      --rm -it \
      -v /tmp/.X11-unix:/tmp/.X11-unix \
      -v "$XAUTHORITY:/tmp/.Xauthority" \
      -v "/run/user/$(id -u)/pulse/:/run/user/0/pulse" \
      docker.io/tiagoapimenta/bb:alpine
