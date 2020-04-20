#!/bin/bash

### Envrionment config
export HOME=/home/vncuser
export NO_VNC_HOME=/home/vncuser/noVNC
export LOG_HOME=/home/vncuser
export VNC_PORT=5901
export NO_VNC_PORT=6080
export VNC_COL_DEPTH=24
export VNC_RESOLUTION=1280x768
export DEBUG=false

# should source $HOME/.bashrc
source $HOME/.bashrc
source $HOME/.profile

## start vncserver and noVNC webclient
echo -e "\n------------------ start noVNC  ----------------------------"
$NO_VNC_HOME/utils/launch.sh --vnc localhost:$VNC_PORT --listen $NO_VNC_PORT & > $LOG_HOME/no_vnc_startup.log 

echo -e "\n------------------ start VNC server ------------------------"
echo "remove old vnc locks to be a reattachable container"
vncserver -kill :1 & > $LOG_HOME/vnc_startup.log \
    || rm -rfv /tmp/.X*-lock /tmp/.X11-unix &> $LOG_HOME/vnc_startup.log \
    || echo "no locks present"

echo -e "start vncserver with param: VNC_COL_DEPTH=$VNC_COL_DEPTH, VNC_RESOLUTION=$VNC_RESOLUTION\n..."
vncserver :1 -depth $VNC_COL_DEPTH -geometry $VNC_RESOLUTION & > $LOG_HOME/vnc_startup.log

## log connect options
echo -e "\n\n------------------ VNC environment started ------------------"
echo -e "\nVNCSERVER started on DISPLAY= :1 \n\t=> connect via VNC viewer with 127.0.0.1:$VNC_PORT"
echo -e "\nnoVNC HTML client started:\n\t=> connect via http://YOUR_IP:$NO_VNC_PORT/?password=...\n"