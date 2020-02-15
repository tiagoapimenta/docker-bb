# Docker Firefox BB (with warsaw)

Used mainly to access [BB](http://www.bb.com.br) internet banking, contains warsaw, run the following command:

    docker run \
      --rm -it \
      -v /tmp/.X11-unix:/tmp/.X11-unix \
      -v "$XAUTHORITY:/tmp/.Xauthority" \
      tpimenta/firefox-bb:ubuntu-lts
