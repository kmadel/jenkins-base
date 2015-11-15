# Docker base image for other CloudBees SA Jenkins images

FROM java:8-jdk
MAINTAINER Kurt Madel <kmadel@cloudbees.com>

RUN apt-get update && apt-get install -y --no-install-recommends \
    openssh-server \
    curl \
    ntp \
    ntpdate

# Create docker group
RUN groupadd docker

# Create Jenkins user
RUN useradd jenkins -d /home/jenkins
RUN echo "jenkins:jenkins" | chpasswd
RUN usermod -a -G docker jenkins

# Make directories for [masters] JENKINS_HOME, jenkins.war lib and [slaves] remote FS root, ssh privilege separation directory
RUN mkdir -p /usr/lib/jenkins /var/lib/jenkins /home/jenkins /var/run/sshd

# Set permissions
RUN chown -R jenkins:jenkins /usr/lib/jenkins /var/lib/jenkins /home/jenkins

# USER jenkins
CMD ["/bin/bash"]
