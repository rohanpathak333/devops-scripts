#!/bin/bash

# STEP-1: Installing Git and Maven
yum install git maven -y

# STEP-2: Repo Information (jenkins.io --> download --> redhat)
wget -O /etc/yum.repos.d/jenkins.repo https://pkg.jenkins.io/redhat-stable/jenkins.repo
rpm --import https://pkg.jenkins.io/redhat-stable/jenkins.io-2023.key

# STEP-3: Download Java 17 and Jenkins
yum install java-17-amazon-corretto -y
yum install jenkins -y

# STEP-4: Create Jenkins tmp directory & override config
mkdir -p /var/jenkins_tmp
chown jenkins:jenkins /var/jenkins_tmp
mkdir -p /etc/systemd/system/jenkins.service.d
echo -e "[Service]\nEnvironment=\"JAVA_OPTS=-Djava.io.tmpdir=/var/jenkins_tmp\"" > /etc/systemd/system/jenkins.service.d/override.conf

# STEP-5: Reload systemd and start Jenkins
systemctl daemon-reload
systemctl start jenkins
systemctl enable jenkins
