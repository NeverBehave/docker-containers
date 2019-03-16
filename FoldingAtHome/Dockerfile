FROM phusion/baseimage:0.11
MAINTAINER MobiusNine

#Dockerfile based on Dockerfiles of smdion

# Set correct environment variables
ENV HOME /root
ENV DEBIAN_FRONTEND noninteractive
ENV LC_ALL C.UTF-8
ENV LANG en_US.UTF-8
ENV LANGUAGE en_US.UTF-8
ENV TERM xterm

#Create Config File
ADD config.xml /root/config.xml

#Add firstrun.sh to create config.xml if needed
ADD firstrun.sh /etc/my_init.d/firstrun.sh

#Add FAHClient-run.sh to temp location
ADD FAHClient-run.sh /root/FAHClient-run.sh

# Use baseimage-docker's init system
CMD ["/sbin/my_init"]

# Configure user nobody to match unRAID's settings
RUN \
usermod -u 99 nobody && \
usermod -g 100 nobody && \
usermod -d /home nobody && \
chown -R nobody:users /home && \

#Install wget/opencl/nvidia driver/cuda
apt-get update -qy && \
apt-get install -qy wget && \

add-apt-repository ppa:graphics-drivers && \

wget --no-check-certificate -P /tmp/ https://developer.nvidia.com/compute/cuda/10.1/Prod/local_installers/cuda-repo-ubuntu1804-10-1-local-10.1.105-418.39_1.0-1_amd64.deb && \
dpkg -i cuda-repo-ubuntu1804-10-1-local-10.1.105-418.39_1.0-1_amd64.deb && \
apt-key add /var/cuda-repo-<version>/7fa2af80.pub && \

apt-get update -qy && \
apt-get install -qy nvidia-driver-418 && \

sudo apt-get install cuda && \
rm /tmp/cuda-repo-ubuntu1804-10-1-local-10.1.105-418.39_1.0-1_amd64.deb && \

apt-get install -qy ocl-icd-opencl-dev && \
apt-get install -qy nvidia-opencl-dev && \

apt-get clean -y && \
rm -rf /var/lib/apt/lists/* && \

#for fan control setting later
#nvidia-xconfig --enable-all-gpus && \
#nvidia-xconfig --cool-bits=4 && \

#Install FAHClient
wget --no-check-certificate -P /tmp/ https://download.foldingathome.org/releases/public/release/fahclient/debian-testing-64bit/v7.4/fahclient_7.4.4_amd64.deb && \
mkdir -p /opt/fah && \
dpkg -x /tmp/fahclient_7.4.4_amd64.deb /opt/fah  && \
rm /tmp/fahclient_7.4.4_amd64.deb && \
chown -R nobody:users /opt/fah && \

#Remove wget
apt-get purge --remove wget -y && \
apt-get autoremove -y && \

# fix up start files and make executable
chmod +x /etc/my_init.d/firstrun.sh && \
mkdir -p /etc/service/fahclient && \
mv /root/FAHClient-run.sh /etc/service/fahclient/run && \
chmod +x /etc/service/fahclient/run

#Expose Ports
EXPOSE 36330 7396

#Expose Config Folder
VOLUME ["/config"]
