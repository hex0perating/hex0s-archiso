#!/bin/bash
echo "Removing old work directories..."
sudo rm -rf work
rm -rf ../working-dir-hex0s
echo "Generating new work directories..."
mkdir ../working-dir-hex0s
cp -r . ../working-dir-hex0s
mv ../working-dir-hex0s work 
echo 'Installing build dependencies...'
yes | sudo pacman -Sy git archiso nodejs npm
echo "Setting up work with scripts..."
git clone https://github.com/hex0perating/hexpm work/hexpm
cd work/hexpm
npm run install-deno 
npm run compile 
cp hexpm ../airootfs/usr/local/sbin
cd ../airootfs/usr/local/sbin/
echo "Contents of /usr/local/sbin/:"
ls
cd ../../../../
echo "Generating ISO..."
mkdir genwork
mkdir out
sudo mkarchiso -v -w genwork/ -o out/ ../
mv out/*.iso ../Installer.iso
echo "ISO has been saved to Installer.iso in the original directory.":
