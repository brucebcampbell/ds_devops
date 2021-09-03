

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
