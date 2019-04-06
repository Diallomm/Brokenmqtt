#Download base image debian 
FROM debian:latest

MAINTAINER Diallomm <misterdiallo1@gmail.com>

#Update system
RUN apt-get update -y

#Install Wget and gnup2
RUN apt-get install wget -y && apt-get install gnupg2 -y && apt-get install vim -y 

#Download and add key
RUN wget http://repo.mosquitto.org/debian/mosquitto-repo.gpg.key 
RUN apt-key add mosquitto-repo.gpg.key
RUN rm mosquitto-repo.gpg.key

## append apt mirror for debian 
RUN echo "# mirror" >> /etc/apt/source.list
RUN echo "deb http://repo.mosquitto.org/debian stretch main" >> /etc/apt/source.list

#Update and upgrade system
RUN apt-get update -y && apt-get upgrade -y 

#install mosquitto 
RUN apt-get install mosquitto -y

#Copy file configuration 
COPY mosquitto.conf /etc/mosquitto

#Copy certificate folder
COPY certs/mosquitto-ca.crt /etc/mosquitto/certs
COPY certs/mosquitto-server.crt /etc/mosquitto/certs
COPY certs/mosquitto-server.key /etc/mosquitto/certs

#Run command 
ENTRYPOINT ["mosquitto", "-c", "/etc/mosquitto/mosquitto.conf"] 
