# manual steps

 * Start weechat, then quit it. 
 * Edit ~/.weechat/irc.conf to add irccloud server section. 
 * Edit ~/.weechat/weechat.conf to add :

```
[startup]
command_after_plugins = "/buffer ##badattitude"
```
