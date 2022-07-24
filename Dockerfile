FROM ubuntu:20.04  

LABEL author="Hila Safi <hila.safi@siemens.com>"


ENV DEBIAN_FRONTEND noninteractive
ENV LANG="C.UTF-8"
ENV LC_ALL="C.UTF-8"

# Install required packages
RUN apt-get update && apt-get install -y \
        python3 \
        python3-pip \
        graphviz


# Add user
RUN useradd -m -G sudo -s /bin/bash hackathon && echo "arcs:arcs" | chpasswd
RUN usermod -a -G staff hackathon
USER arcs

# Add artifacts (from host) to home directory
ADD --chown=arecs:arcs . /home/arcs/arcs

WORKDIR /home/arcs/arcs

# install python packages
ENV PATH $PATH:/home/arcs/.local/bin
RUN pip3 install -r requirements.txt

ENTRYPOINT ["./run.sh"]
CMD ["jupyter"]