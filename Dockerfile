FROM ubuntu:latest

MAINTAINER Erik Ušaj <erik@erikusaj.eu>

ENV DEBIAN_FRONTEND noninteractive

# apt-get update and install tools
RUN apt-get update -y && \
    apt-get install -y \
            apt-utils \
            sudo \
            wget \
            curl \
            unzip \
            nano \
            imagemagick \
            build-essential

# apt-get update and install tools
RUN apt-get -y install libjpeg8-dev libtiff5-dev libjasper-dev libpng12-dev libjpeg-dev
RUN apt-get -y install python-pip python-numpy python-dev
RUN apt-get install cmake cmake-curses-gui -y

# opencv 2.4.11
WORKDIR /tmp/downloads

RUN wget -O opencv-2.4.11.zip http://sourceforge.net/projects/opencvlibrary/files/opencv-unix/2.4.11/opencv-2.4.11.zip/download

RUN unzip opencv-2.4.11.zip && \
    cd opencv-2.4.11 && \
    mkdir build && \
    cd build && \
    cmake -DCMAKE_BUILD_TYPE=RELEASE -D INSTALL_C_EXAMPLES=OFF -D INSTALL_PYTHON_EXAMPLES=OFF -D BUILD_EXAMPLES=OFF  .. && \
    make -j4 && \
    sudo make install && \
    cd ../.. && \
    rm -rf opencv-2.4.11*

# install node
RUN curl -sL https://deb.nodesource.com/setup_6.x | sudo -E bash -
RUN sudo apt-get install -y \
                  nodejs \
                  npm
RUN sudo npm install npm -g
RUN sudo npm install express -g

# install meteor
RUN curl https://install.meteor.com/ | sh

RUN mkdir var\www \
    cd \var\www \
    meteor create meteor_cv \
    cd meteor_cv
