FROM arm64v8/ros:jazzy

# Use bash as the shell for RUN commands.
SHELL ["/bin/bash", "-c"]

# Set working directory
WORKDIR /app

# Install build tools and dependencies
RUN apt-get update && apt-get install -y \
    git \
    cmake \
    build-essential \
    libserial-dev \
    python3-colcon-common-extensions \
 && rm -rf /var/lib/apt/lists/*

# Clone the 10_axis_imu_ros2 repository into /app/src
RUN mkdir -p src && cd src && \
    git clone https://github.com/nguyen-v/10_axis_imu_ros2.git

RUN ls -laR /app/src/10_axis_imu_ros2

# Build and install the serial library
RUN source /opt/ros/jazzy/setup.bash && \
    cd /app/src/10_axis_imu_ros2/serial && \
    mkdir -p build && cd build && \
    cmake .. && \
    make && \
    make install

# Install any missing rosdep dependencies for the workspace
# RUN source /opt/ros/jazzy/setup.bash && \
#     cd /app && \
#     rosdep update && \
#     rosdep install --from-paths src --ignore-src -r -y

# Build the workspace with colcon
RUN source /opt/ros/jazzy/setup.bash && cd /app && colcon build --symlink-install

# Copy the docker entrypoint script and make it executable
COPY docker_entrypoint.sh /app/
RUN chmod +x /app/docker_entrypoint.sh

# Set the entrypoint and default command
ENTRYPOINT ["/app/docker_entrypoint.sh"]
CMD ["bash"]
