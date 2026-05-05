read -p "Do you want to update tammoOS to the latest version?(y/n) " Y
case $Y in
y)
echo "Please enter your root passwort to start"
sudo apt install flatpak
sudo apt install gnome-software-plugin-flatpak
sudo flatpak remote-add --if-not-exists flathub https://dl.flathub.org/repo/flathub.flatpakrepo
flatpak install flathub io.github.kolunmi.Bazaar
notify-send "Hint" "tammoOS got a new software store"

echo -e "\033[41mtammoOS got a new Software Store. To add the new store to the dock you need to right click on the store icon in the dock and click on properties. Then remove the old store and add the new store bazaar with +.\033[0m"
echo -e "\033[41mPlease reboot tammoOS after that!!\033[0m"
esac
exit 0
