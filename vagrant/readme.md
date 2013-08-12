# Vagrant Setup

## Why Vagrant and What is it? 
"Vagrant provides easy to configure, reproducible, and portable work environments built on top of industry-standard technology and controlled by a single consistent workflow to help maximize the productivity and flexibility of you and your team." -  http://docs.vagrantup.com/v2/why-vagrant/index.html

## Step one: Install VirtualBox
Link: https://www.virtualbox.org/wiki/Downloads

## Step two: Install Vagrant
Link: http://downloads.vagrantup.com/
See Vagrant Install Docs for your respective OS. 

## Step three: Get the machine up and running
Once you have the vagrant file from this folder downloaded into a folder. Navigate to that folder in your terminal (Command Prompt for Windows) and run the command ```vagrant up```

If you have never used Vagrant before, it will download an image of Ubuntu 12.04 x64. This might take between 4-30 minutes. 
Once the machine is booted - it will configure itself with the required commands. 

## Use the machine. 
Run the command ```vagrant ssh``` 

## Web Server
The machines IP address is 192.168.*.*