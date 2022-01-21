# fix for screen readers
if grep -Fq 'accessibility=' /proc/cmdline &> /dev/null; then
    setopt SINGLE_LINE_ZLE
fi

echo ""
chmod a+rx /usr/local/bin/hexpm

if [[ $(tty) == "/dev/tty1" ]]; then
  echo "Please wait, initializing desktop..."
  systemctl enable --now NetworkManager
  useradd -m liveuser
  yes liveuser | passwd liveuser 2> /dev/null > /dev/null
  yes liveuser | sudo -u liveuser chsh -s /usr/bin/zsh 2> /dev/null > /dev/null
  cd dots
  cp -r . /home/liveuser/
  chmod -R a+rwx /home/liveuser/
  echo "cat /etc/motd" >> /home/liveuser/.zshrc
  echo "echo ''" >> /home/liveuser/.zshrc
  ln -s /home/liveuser/.zshrc /home/liveuser/.bashrc 
  ln -s /home/liveuser/background_1080.png /home/liveuser/Wallpaper.png
  chmod a+rx /usr/local/bin/starship
  echo "Staring desktop..."
  sudo systemctl enable sddm --now
fi