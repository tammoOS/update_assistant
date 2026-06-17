read -p "Do you want to update tammoOS to the latest version?(y/n) " Y
case $Y in
y)
if [[ "$HOSTNAME" == "tammoOS2.3" ]]; then
git clone https://github.com/tammoOS/update_assistant/
cd update_assistant
chmod +x update_assistant.sh
rm ~/update_assistant.sh
cp update_assistant.sh ~/
rm -rf ~/update_assistant
echo "Your system is up to date"
exit 0
fi

echo "Please enter your root passwort to start"
if [[ "$HOSTNAME" == "tammoOS" ]]; then
sudo apt install flatpak
sudo apt install gnome-software-plugin-flatpak
sudo flatpak remote-add --if-not-exists flathub https://dl.flathub.org/repo/flathub.flatpakrepo
flatpak install flathub io.github.kolunmi.Bazaar
notify-send "Hint" "tammoOS got a new software store"

echo -e "\033[41mtammoOS got a new Software Store. To add the new store to the dock you need to right click on the store icon in the dock and click on properties. Then remove the old store and add the new store bazaar with +.\033[0m"
echo -e "\033[41mPlease reboot tammoOS after that!!\033[0m"
fi

xfconf-query -c xfce4-panel -p /panels/panel-2 -R -r
xfconf-query -c xfce4-panel -p /panels -t int -s 1 -a
xfconf-query -c xfce4-panel -p /panels/panel-2 -r -R
killall xfce4-panel && xfce4-panel &
xfconf-query -c xfce4-panel -p /panels/panel-1/position -s "p=8;x=0;y=0"
xfce4-panel --quit && xfce4-panel &
xfconf-query --channel=xfwm4 --property=/general/inactive_opacity --set=100
xfconf-query -c xfce4-panel -p /panels/panel-1/leave-opacity -n -t int -s 100


hostnamectl set-hostname "tammoOS2.3"
 
  

read -p "reboot?(y/n) " Y
case $Y in
y)
reboot
esac

esac
exit 0
