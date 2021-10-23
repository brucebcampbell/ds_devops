#MAnual Stuff
# sdudo vi /etc/sudoers
#Find a line which contains includedir /etc/sudoers.d
#Below that line add: username ALL=(ALL) NOPASSWD: ALL , where username is your passwordless sudo username;


#Nasty Stuff
wget https://developer.download.nvidia.com/compute/cuda/repos/ubuntu2004/x86_64/cuda-ubuntu2004.pin
sudo mv cuda-ubuntu2004.pin /etc/apt/preferences.d/cuda-repository-pin-600
wget https://developer.download.nvidia.com/compute/cuda/11.4.2/local_installers/cuda-repo-ubuntu2004-11-4-local_11.4.2-470.57.02-1_amd64.deb
sudo dpkg -i cuda-repo-ubuntu2004-11-4-local_11.4.2-470.57.02-1_amd64.deb
sudo apt-key add /var/cuda-repo-ubuntu2004-11-4-local/7fa2af80.pub
sudo apt-get update
sudo apt-get -y install cuda

echo  "
export PATH=/usr/local/cuda-11.4/bin${PATH:+:${PATH}}
"  >> ~/.bashrc


echo  "
export LD_LIBRARY_PATH=/usr/local/cuda-11.4/lib64\
                         ${LD_LIBRARY_PATH:+:${LD_LIBRARY_PATH}}
"  >> ~/.bashrc




sudo apt-get install -y vim
gsettings set org.gnome.shell.extensions.dash-to-dock click-action 'minimize'
sudo apt install -y gnome-tweaks
sudo apt-get install chrome-gnome-shell

gsettings set org.gnome.desktop.background picture-uri ''
gsettings set org.gnome.desktop.background primary-color 'rgb(0, 0, 0)'

git config --global user.email $GITHUB_EMAIL
git config --global user.name $GITHUB_USER


mkdir ~/opt

pip install ranger-fm

sudo apt install bat
echo  "
alias cat='batcat'
"  >> ~/.bashrc

sudo snap install btop
cd ../

echo  "
alias top='btop'
"  >> ~/.bashrc

cd ~

sudo apt-get -y install dstat
#dstat --aio --cpu --cpu-adv --cpu-use --cpu24 --disk --disk24 --disk24-old --epoch --fs --int --int24 --io --ipc --load --lock --mem --mem-adv --net --page --page24 --proc --raw --socket --swap --swap-old --sys --tcp --time --udp --unix --vm --vm-adv --zones

echo  "
alias dstat='dstat --cpu --disk  --fs  --io --ipc --load --lock --mem --net --page  --proc --raw --socket --swap  --sys --tcp --unix --vm  '
"  >> ~/.bashrc

#--------------------HTOP
sudo apt-get -y install htop


#Glances - like htop
sudo apt-get install -y glances



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
source  "/home/bruce/anaconda3/envs/snowflakes/lib/python3.8/site-packages/powerline/bindings/tmux/powerline_tmux_2.1_plus.conf"
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
