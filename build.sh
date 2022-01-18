#!/bin/bash
echo "Removing old work directories..."
sudo rm -rf genwork
sudo rm -rf out
sudo rm -rf /tmp/hexpm
echo "Removing old ISO..."
rm -rf Installer.iso
echo "Generating new work directories..."
mkdir genwork 
mkdir out
echo 'Installing build dependencies...'
yes | sudo pacman -Sy git archiso nodejs npm
git clone https://github.com/hex0perating/hexpm /tmp/hexpm
CURRENTDIR=$PWD
cd /tmp/hexpm 
npm run install-deno 
echo "Setting up work with scripts..."
npm run compile 
cd $CURRENTDIR
cp /tmp/hexpm/hexpm airootfs/usr/local/bin/hexpm 
chmod a+rx airootfs/usr/local/bin/hexpm
echo "Generating ISO..."
sudo mkarchiso -v -w genwork/ -o out/ .
echo "ISO is saved in out/"