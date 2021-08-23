#!/bin/bash

ServerName=bruce-NUC8i7BEH
sudo apt-get update

sudo mkdir /mnt/data
sudo chown ubuntu:ubuntu /mnt/data
sudo chown ubuntu:ubuntu /mnt/data

ln -s /mnt/data /home/ubuntu/data

cd /mnt/data

sudo apt-get -y install git-all
sudo apt-get -y install meld
sudo apt-get -y install default-jre default-jdk
sudo apt-get -y install gdebi postgresql postgresql-contrib pgadmin3 libpq-dev whois imagemagick
sudo apt-get -y install libmagick++-dev libcurl4-openssl-dev
sudo apt-get -y install qpdf texlive-latex-base texlive-fonts-recommended texlive-fonts-extra texlive-latex-extra texinfo
sudo apt-get -y install emacs
sudo apt-get -y install build-essential
sudo apt-get -y install gdebi postgresql postgresql-contrib pgadmin3 libpq-dev whois imagemagick
sudo apt-get -y install libmagick++-dev libcurl4-openssl-dev
sudo apt-get -y install qpdf texlive-latex-base texlive-fonts-recommended texlive-fonts-extra texlive-latex-extra texinfo
sudo apt-get -y install texlive-full
#sudo apt-get install -y default-jre default-jdk
sudo apt-get -y install openjdk-8-jdk
sudo apt-get -y install scala sbt. jq
sudo apt-get -y install awscli
sudo snap install google-cloud-sdk --classic
sudo apt-get -y install postgresql postgresql-contrib
sudo apt-get -y install postgis
sudo -i -u postgres
#psql #opens cli

#LAMP
sudo apt install -y apache2
sudo apt install -y php7.2 libapache2-mod-php7.2 php-mysql
sudo apt install -y php-curl php-json php-cgi
rm $ServerName.conf
echo  "
<Directory /var/www/html/wavescholar.com/public_html>
        Require all granted
</Directory>
<VirtualHost *:80>
        ServerName example.com
        ServerAlias www.wavescholar.com
        ServerAdmin webmaster@localhost
        DocumentRoot /var/www/html/$ServerName/public_html

        ErrorLog /var/www/html/$ServerName/logs/error.log
        CustomLog /var/www/html/$ServerName/logs/access.log combined

</VirtualHost>
"  >> $ServerName.conf
sudo rm /etc/apache2/sites-available/$ServerName.conf
sudo mv $ServerName.conf /etc/apache2/sites-available/$ServerName.conf
sudo mkdir -p /var/www/html/$ServerName/{public_html,logs}
#Link your virtual host file from the sites-available directory to the sites-enabled directory:
sudo a2ensite $ServerName
sudo a2dissite 000-default.conf
sudo systemctl reload apache2

#MySql
sudo apt-get -y install mysql-server
sudo mysql_secure_installation

#My Php phpMyAdmin
sudo apt-get -y install phpmyadmin php-mbstring php-gettext
#The installation process adds the phpMyAdmin Apache configuration file into the
#/etc/apache2/conf-enabled/ directory, where it is read automatically.
#The only thing you need to do is explicitly enable the mbstring PHP extension,
#which you can do by the next step
sudo phpenmod mbstring
sudo systemctl restart apache2

#http://xxx.xxx.xxx.xxx/phpMyAdmin

#Jelyll
sudo apt-get -y install ruby-full build-essential zlib1g-dev libpng-dev zlibc zlib1g
sudo apt-get -y install libxslt-dev libxml2-dev  libxml2  libgcrypt-dev
echo 'export GEM_HOME="$HOME/gems"' >> ~/.bashrc
echo 'export PATH="$HOME/gems/bin:$PATH"' >> ~/.bashrc
source ~/.bashrc
gem install jekyll bundler

git clone https://github.com/redwallhp/solar-theme-jekyll.git
cd solar-theme-jekyll
echo  "
source 'https://rubygems.org'
gem 'jekyll-paginate'
gem 'rogue'
gem 'jekyll'
gem 'json'
gem 'redcarpet'
"  >> Gemfile
bundle install

#  show xterm 256olors
for i in {0..255} ; do     printf "\x1b[38;5;${i}mcolour${i}\n"; done;

#--------------------MIDNIGHT COMMANDER : visual file system viewer

cd ~
sudo apt-get -y install mc
git clone https://gist.github.com/Ajnasz/8685681
mkdir ~/.mc
mkdir ~/.mc/skins
cp 8685681/ajnasz-blue.ini  ~/.mc/skins/
#.config/mc/ini adding a line containing skin=ajnasz-blue
git clone https://github.com/nkulikov/mc-solarized-skin
cp mc-solarized-skin/solarized.ini ~/.mc/skins/
git clone https://github.com/MidnightCommander/mc
cp mc/misc/skins/*.ini ~/.mc/skins/

#---------------user_name customize skin
cd ~/.mc/skins
sed -i -- 's/black/color024/g' gotar.ini
#sed -i -- 's/button = white;blue/button = white;color178/g' gotar.ini

cd ~

sudo apt-get -y install dstat
#dstat --aio --cpu --cpu-adv --cpu-use --cpu24 --disk --disk24 --disk24-old --epoch --fs --int --int24 --io --ipc --load --lock --mem --mem-adv --net --page --page24 --proc --raw --socket --swap --swap-old --sys --tcp --time --udp --unix --vm --vm-adv --zones

echo  "
alias dstat='dstat --cpu --disk  --fs  --io --ipc --load --lock --mem --net --page  --proc --raw --socket --swap  --sys --tcp --unix --vm  '
"  >> ~/.bashrc

#--------------------HTOP
sudo apt-get -y install htop
sudo apt-get -y install ncurses-devel
sudo apt-get -y install libncurses5-dev libncursesw5-dev



#We build a custom htop to get control over the colors
cd ~
wget http://pronto185.com/tar/htop-1.0.1-pronto-red.tar.gz
gunzip htop-1.0.1-pronto-red.tar.gz
tar xfs htop-1.0.1-pronto-red.tar
cd htop-1.0.1-pronto-red
./configure
make

echo  "
alias htop='htop-1.0.1-pronto-red/htop'
"  >> ~/.bashrc

#Glances - like htop
sudo apt-get install -y glances


#-------------------------DirColors Solarized
git clone  https://github.com/seebi/dircolors-solarized

echo  '
eval `dircolors ~/dircolors-solarized/dircolors.ansi-light`
'  >> ~/.bashrc

#OR
# sudo apt-get install dconf-cli
# cd gnome-terminal-colors-solarized
# ./install.sh
# echo  '
# eval `dircolors /home/ubuntu/.dir_colors/dircolors`
# '  >> ~/.bashrc
#---------------------------------


#-------------------------TMUX
sudo apt-get -y install tmux
tmux set -g prefix 'C-a'

echo  '
set -g default-terminal "screen-256color"
set -g pane-border-fg colour136
set -g pane-active-border-fg colour148
set -g pane-border-bg colour235
set -g pane-active-border-bg colour236
set -g mode-mouse on
set -g mouse-select-pane on
set -g mouse-resize-pane on
set -g mouse-select-window on
set -g mode-mouse on
set -g mouse-select-pane on
set -g mouse-resize-pane on
set -g mouse-select-window on
source  "~/.local/lib/python3.6/site-packages/powerline/bindings/tmux/powerline_tmux_2.1_plus.conf"
'  >> ~/.tmux.conf


ln -s /mnt/data/ds-devops/start_tmux_session-monitor.sh ~/mon-tmux.sh
ln -s /mnt/data/ds-devops/start_tmux_session-dev.sh ~/dev-tmux.sh
#-------------------------Write Aliases
echo  "
alias du='du --max-depth=1 /home/ | sort -n -r | more'
alias l.='ls -d .* --color=auto'
alias ll='ls -l --color=auto'
alias ls='ls -lat --color=auto'
alias mc='. /usr/libexec/mc/mc-wrapper.sh'
alias vi='vim'
alias tmux='tmux -2'  #for 256 colors
"  >> ~/.bashrc
