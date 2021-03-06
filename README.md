# Config

You'll need to manually tweak the launch config and spot request JSON
to match your subnet and security group ids. The AMI is Ubuntu Server
LTS 18.04, so you might also want to play with that.


# To use

Create the launch template from `launch-template.json`, updating
security group ids as required (mine allow `ssh` on ports 22 and
stunnel on 443 from anywhere). Update `spot-request.json` with the
template id and version, and set the subnets to match your VPC. Then
run:

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


## User data script

If you change `user-data.sh` you will need to base64 encode it and
drop that string into `spot-request.json`.

# Setting up stunnel


Install `stunnel4` (e.g. `brew install stunnel`). Edit
`stunnel-client.conf` with the path to this key, and the IP address of
your server, then start stunnel:

```
stunnel stunnel-client.conf
```

You should now be able to ssh over the tunnel like:

```
ssh -p 1443 localhost
```

(specifying users and identity files as required).


# Manual steps to config weechat

I haven't tried to script the configuration of `weechat` because it's
haaaarrdddd. So, you'll need to do these parts manually if you are
using weechat:

 * Start `weechat`, then quit it. [this creates the default config]
 * Edit `~/.weechat/irc.conf` to add a server section for your server 

If you really wanted to automate this, the easiest way is probably to
create a working config dir (`~/.weechat/`), tar it up and drop it
into S3. Then you could add a few lines of user data script to
download and expand it.
