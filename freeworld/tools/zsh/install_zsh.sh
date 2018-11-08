#!/usr/bin/env bash
basepath=$(cd `dirname $0`; pwd)

apt-get install -y zsh
apt-get install -y git

cd ~
wget https://github.com/robbyrussell/oh-my-zsh/raw/master/tools/install.sh -O - | sh

cd ~/.oh-my-zsh/themes/
sed -i "s/PROMPT='\${ret_status} %{\$fg\[cyan\]%}%c%{\$reset_color%} \$(git_prompt_info)'/PROMPT='\${ret_status} %{\$fg[cyan]%}%10c%{\$reset_color%} \$(git_prompt_info)>'/g" robbyrussell.zsh-theme

apt-get install -y autojump
echo ". /usr/share/autojump/autojump.sh" >> ~/.zshrc
echo "alias ll='ls -al'" >> ~/.zshrc