if [ ! -d "/home/ros2/workspace/ros2_ws/code_analysis" ]; then
    mkdir -p /home/ros2/workspace/ros2_ws/code_analysis;
fi
export CC="scan-build -o /home/ros2/workspace/ros2_ws/code_analysis  clang";
export CXX="scan-build -o /home/ros2/workspace/ros2_ws/code_analysis  clang++";
colcon build --symlink-install --cmake-force-configure;
