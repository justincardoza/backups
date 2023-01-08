# Backing up my data

This repository is all about my backup strategy. It's very much a work in 
progress, and probably always will be, but I want to share it in case it's 
useful to anyone. My current setup is:

- [restic](https://restic.net) for managing backup data
- [Backblaze B2](https://www.backblaze.com/b2/cloud-storage.html) for storing it
- [secret-tool](https://manpages.org/secret-tool) for keeping keys and passwords safe
- A few shell scripts to make the backup actions themselves easier

Initially, I started out following the `restic` documentation and 
[this excellent guide](https://help.backblaze.com/hc/en-us/articles/4403944998811-Quickstart-Guide-for-Restic-and-Backblaze-B2-Cloud-Storage)
from Backblaze. I did my first rounds of backups on my old Windows system 
using the recommended environment variables and entering the `restic` password 
at the prompt, but on Linux, I wanted to put together a more security-oriented 
way of doing backups. Maybe it's my background in healthcare software with the 
accompanying security requirements, but I don't feel comfortable storing 
sensitive data like keys and passwords in plaintext, even if only `root` 
technically has permission to access it. That only helps as long as the OS 
is running to enforce permissions, and as long as nobody else gains `root` 
access to my system somehow. Those are both worst-case scenarios, but 
compromises like that _do_ happen.

I found a few mentions of `secret-tool` when researching how to securely 
store passwords etc. on Linux, but no ready-made examples of how to apply 
that to my setup. My goal for the scripts in this repository is to be that 
example (as well as, you know, being functional for backing up my files). 
Fortunately it's easy to set up and use secrets using the command. There are 
great examples of it in action in the scripts, but for a quick reference here,
this is how it's used to store a secret:

```
secret-tool store --label='Descriptive label' key1 value1 key2 value2
```

It then prompts for a "Password:" which is the secret to store. It's also 
possible to pipe in text on `stdin` which will then allow newlines as 
part of the data; I didn't see the need to do that for any of what I was 
storing to get my backups set up. Then, to use the stored secret:

```
secret-tool lookup key1 value1 key2 value2
```

... will print the stored secret to `stdout` with a newline after it. This 
can be stored into an environment variable in a script, or in the case of 
the repository password, I just give `restic` the command itself to run when 
it needs the password.

Note that key1, value1, etc. etc. should be replaced with descriptive 
key-value attributes to uniquely identify a secret entry. So for example, 
your repository password could be stored with a key of 'backup' and an 
associated value of 'restic-repository-password'. It occurs to me that 
publishing the exact attributes I use for my backup secrets would probably 
not be the best idea, so I'm using example placeholders in these scripts 
which make sense for what each item is.

This tool is used to access the Secret Service API, a freedesktop.org 
specification which is implemented by `gnome-keyring` among others. It stores 
secrets such as passwords encrypted on disk, and the default collection is 
typically automatically decrypted on login for convenience. That means 
someone can't just look at my system drive and see my passwords right away. 
It's still possible for secrets in this storage to be compromised, but it 
adds a layer of security without making anything inconvenient. If there's 
one thing that will discourage just about anyone from doing regular backups, 
it's how much of a hassle it can be if there are a lot of manual steps.

It's also good to note, I don't recommend _only_ storing your backup secrets 
using `secret-tool`. I keep mine in my password manager and then also have a 
copy stored in my main computer's keyring. That way, if anything happens to 
my computer or system drive, I still have my keys and everything stored 
elsewhere.

## Miscellaneous References

- https://restic.readthedocs.io/en/latest/manual_rest.html
- https://forum.restic.net/t/read-password-from-gnome-keyring/1094
- https://gitlab.gnome.org/GNOME/libsecret
