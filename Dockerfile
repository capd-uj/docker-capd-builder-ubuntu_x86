FROM ubuntu:19.04
MAINTAINER Mateusz Juda <mateusz.juda@gmail.com>

# because of docker cache we have to update/upgrade just before install
RUN apt-get update -y && apt-get upgrade -yy && DEBIAN_FRONTEND=noninteractive apt-get install -yy gcc g++ make pkg-config automake autoconf libtool libwxgtk...-dev libmpfr-dev libboost-all-dev liblog4cxx-dev libpari-dev libx11-dev  python-numpy python3-numpy python-pip python3-pip python-setuptools python3-setuptools python-dev python2..-dev python3..-dev subversion libjpeg-dev zlib1g-dev libgl1-mesa-dev libglu1-mesa-dev libxt-dev libjpeg-dev libxmu-dev

# ADD usr/local /usr/local

ADD https://bitbucket.org/phat-code/phat/get/v1.4.1.tar.gz /usr/local/src/phat.tar.gz

# It is better to copy to /usr/include not /usr/local because /usr/local ma be remounted later
RUN cd /usr/local/src/ && tar xzf phat.tar.gz && \
    cp -fr /usr/local/src/phat*/include/phat /usr/include/ && rm -fr /usr/local/src/phat*

RUN  pip install munkres PILLOW Cython nose

# RUN /usr/local/src/install_mathematica.sh
# RUN /usr/local/src/install_matlab.sh

# VOLUME /usr/local/lib/Wolfram
# VOLUME /usr/local/lib/MATLAB
# VOLUME /usr/local/bin

ENV CROSS_TARGET_HOST=""

