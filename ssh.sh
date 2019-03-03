ssh -i ~/.ssh/mojain-ap-southeast-2.pem -t ubuntu@$(./find-ip.sh) tmux attach
