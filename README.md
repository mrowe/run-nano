# Config

You'll need to manually tweak the launch config and spot request JSON
to match your subnet and security group ids. The AMI is Ubuntu Server
LTS 18.04, so you might also want to play with that.


# To use

Create the launch template from `launch-template.json`, updating
security group ids as required (mine allow `ssh` on ports 22 and 443
from anywhere). Update `nano-spot-request.json` with the template id
and version, and set the subnets to match your VPC. Then run:

```
./launch.sh
```

to launch the spot request. Wait a few minutes, then run

```
./find-ip.sh
```

to get your instance's public IP address. *NOTE* obviously this will
return public IPs for _all_ instances running in your account in your
default region. If you're running more than the one created above I
assume you can figure out how to find the right IP yourself. :-D


# Manual steps

 * Start weechat, then quit it. 
 * Edit ~/.weechat/irc.conf to add irccloud server section. 
 * Edit ~/.weechat/weechat.conf to add :

```
[startup]
command_after_plugins = "/buffer ##badattitude"
```
