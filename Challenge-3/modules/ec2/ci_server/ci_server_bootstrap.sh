#!/bin/bash
# Update the repositories and packages to latest version available
sudo yum -y update
# Add EPEL Repository
# Install necessary base packages
# Install Java for Jenkins
sudo yum -y install epel-release vim wget curl unzip zip java-1.8.0-openjdk-devel
# Place the Jenkins Repo file under /etc/yum.repos.d
sudo wget -O /etc/yum.repos.d/jenkins.repo https://pkg.jenkins.io/redhat-stable/jenkins.repo
# Import the GPG Key
sudo rpm --import https://pkg.jenkins.io/redhat-stable/jenkins.io.key
# Install Jenkins
# Install Ansible
# Install Nginx Web Server for Reverse Proxy
sudo yum -y install jenkins ansible nginx
# Put the Nginx Reverse Proxy Configuration for Jenkins
cat << _END | sudo tee -a /etc/nginx/conf.d/jenkins.conf 
server {
listen 80;
server_name jenkins.equalexperts.com;

location / {
    # Fix the "It appears that your reverse proxy set up is broken" error.
    proxy_pass          http://127.0.0.1:8080;
    proxy_read_timeout  90;
}
}
_END
# Disable SELinux Temporarly
sudo setenforce 0
# Change listen address in Jenkins
sudo sed -i 's/JENKINS_LISTEN_ADDRESS=""/JENKINS_LISTEN_ADDRESS="127.0.0.1"/g' /etc/sysconfig/jenkins
# Start/Enable the Jenkins Server
sudo systemctl start jenkins.service
sudo systemctl enable jenkins.servi
# Start/Enable Nginx Server
sudo systemctl start nginx.service
sudo systemctl enable nginx.service