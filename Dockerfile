FROM phusion/baseimage:0.11
MAINTAINER <i@never.pet>NeverBehave

#Dockerfile based on Dockerfiles of smdion

# Set correct environment variables
ENV HOME="/root" \
        DEBIAN_FRONTEND=noninteractive\
        LC_ALL=C.UTF-8 \
        LANG=en_US.UTF-8 \
        LANGUAGE=en_US.UTF-8 \
        TERM=xterm

# Set Config Vars
ENV GPU_STATUS=false \
          ALLOW_SUBNET_HTTP="0.0.0.0/0" \
          PASSWORD="PASSWORD" \
          TEAM_ID="239854" \
          USER_ID="Anonymous" \
          PASSKEY="" \
          ALLOW_SUBNET_WEB="0.0.0.0/0" \
          POWER="medium"

# Use baseimage-docker's init system
CMD ["/sbin/my_init"]

# Configure user nobody to match unRAID's settings
RUN usermod -u 99 nobody && \
        usermod -g 100 nobody && \
        usermod -d /home nobody && \
        chown -R nobody:users /home && \
        #Install wget/opencl
        apt-get update -q && \
        apt-get install -qy wget && \
        apt-get install -y ocl-icd-opencl-dev && \
        apt-get install -y nvidia-opencl-dev && \
        apt-get clean -y && \
        rm -rf /var/lib/apt/lists/* && \
        #Install FAHClient
        wget --no-check-certificate -P /tmp/ https://download.foldingathome.org/releases/public/release/fahclient/debian-stable-64bit/v7.5/latest.deb && \
        mkdir -p /opt/fah && \
        dpkg -x /tmp/latest.deb /opt/fah  && \
        rm /tmp/latest.deb && \
        chown -R nobody:users /opt/fah && \
        #Remove wget
        apt-get purge --remove wget -y && \
        apt-get autoremove -y 

#Create Config File
ADD config.xml /root/config.xml

#Add firstrun.sh to create config.xml if needed
ADD firstrun.sh /etc/my_init.d/firstrun.sh

#Add FAHClient-run.sh to temp location
ADD FAHClient-run.sh /root/FAHClient-run.sh

# fix up start files and make executable
RUN chmod +x /etc/my_init.d/firstrun.sh && \
        mkdir -p /etc/service/fahclient && \
        mv /root/FAHClient-run.sh /etc/service/fahclient/run && \
        chmod +x /etc/service/fahclient/run && \
        mkdir /config

#Expose Ports
EXPOSE 36330 7396

#Expose Config Folder
VOLUME ["/config"]
