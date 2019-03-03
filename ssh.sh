ssh -i ~/.ssh/mojain-ap-southeast-2.pem -t ubuntu@$(./find_ip.sh) tmux attach
