#!/bin/bash
xhost +local:docker
docker run -it --rm \
  -v ~/Documents/Repos/PX4-Autopilot:/src/PX4-Autopilot \
  -e DISPLAY=$DISPLAY \
  -e LIBGL_ALWAYS_SOFTWARE=1 \
  -e PX4_HOME_LAT=37.915926 \
  -e PX4_HOME_LON=-122.33526 \
  -e PX4_HOME_ALT=7.0 \
  -v /tmp/.X11-unix:/tmp/.X11-unix \
  --device=/dev/ttyACM0 \
  --network=host \
  --privileged \
  px4io/px4-dev-simulation-focal:latest \
  bash -c "git config --global --add safe.directory '*' && \
           cd /src/PX4-Autopilot && \
           source Tools/simulation/gazebo-classic/setup_gazebo.bash \$(pwd) \$(pwd)/build/px4_sitl_default && \
           gazebo Tools/simulation/gazebo-classic/sitl_gazebo-classic/worlds/hitl_fighter_vtol.world"
