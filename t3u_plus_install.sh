#!/bin/sh


set -e
password=$1


echo "============================================================"
echo "Starting installation of drivers for Tplink T3U-Plus adapter"
echo "----------------------------------------------by anvish-----"
echo "============================================================"

read -n 1 -s -r -p "Please unplug your TPlink device (press any key to continue)"

# Install DKMS
echo "*** Installing DKMS ***"
echo $password | sudo -S apt-get -y install dkms

# Get the driver from Github and install it with DKMS
echo "*** Downloading the drivers ***"
echo $password | sudo -S git clone "https://github.com/RinCat/RTL88x2BU-Linux-Driver.git" /usr/src/rtl88x2bu-git
echo "*** Installing the drivers ***"
echo $password | sudo -S sed -i 's/PACKAGE_VERSION="@PKGVER@"/PACKAGE_VERSION="git"/g' /usr/src/rtl88x2bu-git/dkms.conf
echo $password | sudo -S dkms add -m rtl88x2bu -v git
echo "------------------------------------------------------------"
echo "Disclaimer: This step will take a long while to complete"
echo "based on your device's performance. However please do not"
echo "shutdown or restart the device until the whole process is"
echo "completed or when you are told to do so."
echo "------------------------------------------------------------"
echo $password | sudo -S dkms autoinstall
echo "============================================================"
echo "Installation is complete. You should now restart your device
echo "============================================================"
