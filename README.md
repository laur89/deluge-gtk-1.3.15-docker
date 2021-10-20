## Running

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

If the user permissions are messed up, try explicitly passing `-u $(whoami)` 
to try and fix the file permission issues.

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
