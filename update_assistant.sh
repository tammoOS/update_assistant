#!/bin/bash
echo "YOU NEED AN INTERNET CONNECTION!"
read -p "Do you want to update tammoOS to the latest version?(y/n) " Y
case $Y in
n)
exit 0
esac
if [ "$HOSTNAME" = "tammoOS2.5" ]; then
git clone https://github.com/tammoOS/update_assistant/
cd update_assistant
chmod +x update_assistant.sh
rm $HOME/update_assistant.sh
cp update_assistant.sh $HOME/
rm -rf $HOME/update_assistant
echo "Your system is up to date"
notify-send "Update Assistant" "Your system is up to date"
exit 0
fi

if [ ! -f "$HOME/.config/autostart/autoupdate.desktop" ]; then
read -p "Do you want to check for Updates on startup?(y/n)" Y
case $Y in
y)
cat > "$HOME/.config/autostart/autoupdate.desktop" <<EOF
[Desktop Entry]
Type=Application
Name=autoupdate
Comment=Update_Script
Exec="/$HOME/update_assistant.sh"
Terminal=true
X-GNOME-Autostart-enabled=true
EOF
sudo chmod +x autoupdate.desktop
esac
fi
read -p "Is this version of tammoOS correct?(y/n): $HOSTNAME" Y
case $Y in
n)
read -p "With Version is right (2.1.1 or newer)" Version
case $Version in
2.1.1)
echo "Please enter your root passwort first"
hostnamectl set-hostname "tammoOS"
echo "Please reboot before continue"
exit 0
esac
esac
if [ "$HOSTNAME" = "tammoOS" ]; then
sudo apt install flatpak
sudo apt install gnome-software-plugin-flatpak
flatpak install flathub io.github.kolunmi.Bazaar
notify-send "Hint" "tammoOS got a new software store"

echo -e "\033[41mtammoOS got a new Software Store.\033[0m"

xfconf-query -c xfce4-panel -p /panels/panel-2 -R -r
xfconf-query -c xfce4-panel -p /panels -t int -s 1 -a
xfconf-query -c xfce4-panel -p /panels/panel-2 -r -R
killall xfce4-panel && xfce4-panel &
xfconf-query -c xfce4-panel -p /panels/panel-1/position -s "p=8;x=0;y=0"
xfce4-panel --quit && xfce4-panel &
xfconf-query --channel=xfwm4 --property=/general/inactive_opacity --set=100
xfconf-query -c xfce4-panel -p /panels/panel-1/leave-opacity -n -t int -s 100

fi
echo -e "\033[41mUpdate the System and clean up.\033[0m"
sudo apt update
sudo apt upgrade
sudo apt clean
sudo apt autoremove --purge
sudo apt autoclean
sudo apt --fix-broken install

xfconf-query -c xfwm4 -p /general/wrap_windows -n -t bool -s false
xfconf-query -c xfwm4 -p /general/snap_to_border -n -t bool -s true
xfconf-query -c xfce4-panel -p /plugins/plugin-17/show-labels -s false

hostnamectl set-hostname "tammoOS2.5"
 

read -p "reboot(y/n)" Y
case $Y in
y)
sudo reboot
exit 0
;;
esac