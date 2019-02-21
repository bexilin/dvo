# Use bare ubuntu 18.10 (cosmic)
FROM ubuntu:cosmic

# Set working directory /dvo_core
WORKDIR /dvo_core

# Install dependencies
RUN apt update && apt upgrade -y && DEBIAN_FRONTEND=noninteractive apt install -y \
  build-essential \
  cmake \
  libopencv-dev \
  libeigen3-dev \
  libboost-dev

# Install Sophus
ENV commit 26c200265e2eb3d76e5ab00a99ada686d6a80d15
RUN apt install -y curl unzip \
  && curl -L https://github.com/strasdat/Sophus/archive/${commit}.zip --output sophus.zip \
  && unzip sophus.zip \
  && rm sophus.zip \
  && cd Sophus-${commit} \
  && mkdir build && cd build \
  && cmake .. && make && make install \
  && cd ../../ && rm -rf Sophus-${commit}

# Copy the current directory to container
# Cannot use one COPY since it copy the content (not the dir itself)
COPY include include
COPY src src
COPY CMakeLists.txt .
