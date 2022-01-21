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
echo "Transferring dotfiles..."
rm -rf airootfs/root/dots 
git clone https://github.com/hex0perating/rice airootfs/root/dots --depth=1
rm -rf airootfs/root/dots/.git 
rm -rf airootfs/root/dots/starship_installer
rm -rf airootfs/root/dots/LICENSE
rm -rf airootfs/root/dots/README.md
echo "Downloading starship..."
CURRENTDIR=$PWD 
cd /tmp 
wget "https://github.com/starship/starship/releases/download/v1.2.1/starship-x86_64-unknown-linux-musl.tar.gz"
echo "Installing starship..."
tar -xvf starship-x86_64-unknown-linux-musl.tar.gz
cd $CURRENTDIR
mv /tmp/starship airootfs/usr/local/bin/starship
echo "Generating ISO..."
sudo mkarchiso -v -w genwork/ -o out/ .
echo "ISO is saved in out/"