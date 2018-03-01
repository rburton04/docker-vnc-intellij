FROM kaixhin/vnc:latest
MAINTAINER Murphy McMahon <pandeiro.docker@gmail.com>

#
# System tools
#
RUN apt-get update && \
    apt-get install -y wget software-properties-common openjdk-7-jdk && \
    rm -rf /var/lib/apt/lists/*
#RUN add-apt-repository ppa:webupd8team/java -y
#RUN apt-get update
#RUN echo "y" | apt-get install oracle-java8-installer

RUN wget -q -O - https://dl-ssl.google.com/linux/linux_signing_key.pub | sudo apt-key add -
RUN echo 'deb [arch=amd64] http://dl.google.com/linux/chrome/deb/ stable main' | sudo tee /etc/apt/sources.list.d/google-chrome.list
RUN apt-get update
RUN echo "y" | apt-get install google-chrome-stable

#
# Install IDEA CE
#
# From tarball
WORKDIR /tmp
RUN wget -q 'https://download.jetbrains.com/idea/ideaIC-2017.3.4.tar.gz' && \
    tar xzf ideaIC-2017.3.4.tar.gz && rm ideaIC-2017.3.4.tar.gz && \
    mv idea-* /opt/idea && \
    ln -s /opt/idea/bin/idea.sh /usr/local/bin/idea.sh

WORKDIR /

# Add launcher
COPY intellij.desktop /usr/share/applications/intellij.desktop
