#!/bin/bash
echo "Port 22" >> /etc/ssh/sshd_config
echo "Port 443" >> /etc/ssh/sshd_config
systemctl restart ssh.service
apt-get update
apt-get install -y weechat tmux

cat << EOF > /home/ubuntu/.tmux.conf
set -g prefix C-z
unbind C-b
bind C-z send-prefix
bind C-d detach

set -g status-bg blue
set -g status-fg white
set -g status-left '#[fg=green]#H'
set -g status-right '#T'

set-window-option -g window-status-current-bg magenta

set -g status-right '#(cat /proc/loadavg)'

new -d -n 'shell'
neww -d -n weechat 'weechat'

# leave me in the first window
select-window -t0
EOF