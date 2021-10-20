# Dockerized Deluge 1.3.15 thin client

This is so we can connect to Deluge servers/daemons still running on old
v1.3.X. It's so old it's likely not available in your distro anymore; likely
'cause old Deluge depends on now-deprecated py 2.7.


### Enabling GUI over Docker

Note you need to create your $XAUTH file on host in order to use X11 apps over Docker:

- `export XAUTH=$HOME/.docker.xauth`
  - note this step needs to be done upon every reboot
- `touch $XAUTH`
- `xauth nlist $DISPLAY | sed -e 's/^..../ffff/' | xauth -f $XAUTH nmerge -`

(note this setup is taken from [here](https://towardsdatascience.com/real-time-and-video-processing-object-detection-using-tensorflow-opencv-and-docker-2be1694726e5))


### Running

First build image `docker build .`

Then run:

```
docker run --rm -d \
  --name deluge \
  -e DISPLAY \
  -e XAUTHORITY=$XAUTH \
  -v /tmp/.X11-unix/:/tmp/.X11-unix/ \
  -v $HOME/.config/deluge-1.3.15-seedbox:/home/deluge/.config/deluge \
  -v /data:/data:ro \
  -v $HOME/Downloads/:/downloads \
  -v $XAUTH:$XAUTH \
  <image_id>
```

Note `-v /data:/data:ro` is to enable our plugins/ symlink in mounted config dir.
You might want to modify the mounted volumes.

If the user permissions are messed up, try explicitly passing `-u $(whoami)` 
to try and fix the file permission issues:

```
docker run --rm -d \
  --name deluge \
  -u $(whoami) \
  -e DISPLAY \
  -e XAUTHORITY=$XAUTH \
  -v /tmp/.X11-unix/:/tmp/.X11-unix/ \
  -v $HOME/.config/deluge-1.3.15-seedbox:/home/deluge/.config/deluge \
  -v /data:/data:ro \
  -v $HOME/Downloads/:/downloads \
  -v $XAUTH:$XAUTH \
  <image_id>
```

