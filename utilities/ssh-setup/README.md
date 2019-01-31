
# How to setup ssh using pgp auth from yubikey neo smartcard on fedora (currently silverblue 29)

## References:
* https://eklitzke.org/using-gpg-agent-effectively
* https://github.com/drduh/YubiKey-Guide#ssh
* https://gist.github.com/ageis/14adc308087859e199912b4c79c4aaa4
* https://wiki.archlinux.org/index.php/GnuPG#gpg-agent

## Packages to install:

Need the yubikey bits:
```
sudo rpm-ostree install yubikey-manager
```
Make sure that's working:
```
gpg2 --card-status
```


## Files to configure:
```
cp 
```

Put these lines in .bashrc
```
export GPG_TTY="$(tty)"
export SSH_AUTH_SOCK="/run/user/$UID/gnupg/S.gpg-agent.ssh"
gpg-connect-agent updatestartuptty /bye
```

