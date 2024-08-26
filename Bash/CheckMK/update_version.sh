
# update packages
sudo apt update -y | sudo apt upgrade -y

# fetch latest installer
# Ubuntu 24.04
wget https://download.checkmk.com/checkmk/2.3.0p13/check-mk-raw-2.3.0p13_0.noble_amd64.deb
# Ubuntu 22.04
#wget https://download.checkmk.com/checkmk/2.3.0p13/check-mk-raw-2.3.0p13_0.jammy_amd64.deb
# Ubuntu 20.04
#wget https://download.checkmk.com/checkmk/2.3.0p13/check-mk-raw-2.3.0p13_0.focal_amd64.deb

# install the new version
# Ubuntu 24.04
sudo apt install ./check-mk-raw-2.3.0p13_0.noble_amd64.deb
# Ubuntu 22.04
#sudo apt install ./check-mk-raw-2.3.0p13_0.jammy_amd64.deb
# Ubuntu 20.04
#sudo apt install ./check-mk-raw-2.3.0p13_0.focal_amd64.deb

# at this stage it is recommended to disable notifications so you are not flooded with alerts that your hosts/services are flapping

# stop the hosted sites
omd stop

# backup the site before update/upgrade to avoid possible data loss
#omd backup mysite /path/to/backup/directory/mysite.tar.gz

# update the checkmk version
omd update

# if you need to you can restore the site
#omd restore /path/to/backup/directory/mysite.tar.gz

# start sites
omd start

# also if you want to backup the site and dump it onto a new server
#omd backup mysite - | ssh user@host "cat > /path/to/directory.mysite.tar.gz"