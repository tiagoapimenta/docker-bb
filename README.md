# Docker BB

Used mainly to access [BB](http://www.bb.com.br), run the following command:

    docker run \
      --rm -it \
      -v /tmp/.X11-unix:/tmp/.X11-unix \
      -v "$XAUTHORITY:/tmp/.Xauthority" \
      -v "/run/user/$(id -u)/pulse:/tmp/pulse" \
      -v "$HOME/.pulse-cookie:/tmp/.pulse-cookie" \
      tpimenta/firefox-bb:ubuntu-lts
