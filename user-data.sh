#!/bin/bash
apt-get update
apt-get install -y stunnel weechat tmux

# set up stunnel
cat <<EOF > /tmp/cert.cnf
[ req ]
prompt = no
distinguished_name = dn
[ dn ]
C = AU
O = Acme
CN = server
EOF

cat << EOF > /etc/stunnel/stunnel.conf
pid = /var/run/stunnel.pid
cert = /etc/stunnel/stunnel.pem
[ssh]
accept = *:443
connect = 127.0.0.1:22
EOF

sed -i 's/^ENABLED=0/ENABLED=1/'  /etc/default/stunnel4

openssl genrsa 1024 > /tmp/stunnel.key
openssl req -new \
        -key /tmp/stunnel.key \
        -x509 \
        -days 1000 \
        -out /tmp/stunnel.crt \
        -config /tmp/cert.cnf
cat /tmp/stunnel.crt /tmp/stunnel.key > /etc/stunnel/stunnel.pem

sleep 2
service stunnel4 restart

# set up tmux

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
