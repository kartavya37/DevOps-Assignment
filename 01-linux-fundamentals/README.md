# Linux Fundamentals

**Name:** Kartavya Panchal
**Roll No.:** 24BCS10343

My laptop is a Mac, and `useradd`, `adduser` and `journalctl` don't exist there. So I did
these tasks in an Ubuntu 24.04 container booted with systemd as PID 1, which gives a real
journal to query:

```bash
docker run -d --name linux-lab --hostname linux-lab \
  --privileged --cgroupns=host --tmpfs /run --tmpfs /run/lock \
  linux-lab:24.04
```

Everything below is copied out of that container.

---

## Task 1: soft link vs hard link

A filename is only a pointer to an inode, and the inode is where the data actually sits. A
hard link is a second name pointing at the same inode. A soft link is a separate small file
that stores a path as text.

Almost everything else follows from that. Delete the original and the hard link still works,
because the data is freed only when the link count reaches zero. The soft link breaks,
because the path it saved no longer resolves. Hard links can't cross filesystems, since inode
numbers are only unique inside one filesystem, and Linux won't let you hard link a directory
(you could build a loop in the tree). Soft links have neither restriction.

```bash
ln  original.txt hard-link.txt      # hard link, no flag
ln -s original.txt soft-link.txt    # soft link
ls -li                              # -i shows inode numbers
readlink soft-link.txt              # where does this symlink point
rm soft-link.txt                    # removes either kind
```

```console
$ echo "This is the original file." > original.txt

$ ln -s original.txt soft-link.txt

$ ln original.txt hard-link.txt

$ ls -li
total 8
1716237 -rw-r--r-- 2 root root 27 Sep  3 15:52 hard-link.txt
1716237 -rw-r--r-- 2 root root 27 Sep  3 15:52 original.txt
1716238 lrwxrwxrwx 1 root root 12 Sep  3 15:52 soft-link.txt -> original.txt

$ cat soft-link.txt
This is the original file.

$ cat hard-link.txt
This is the original file.

### delete the original
$ rm original.txt

$ ls -li
total 4
1716237 -rw-r--r-- 1 root root 27 Sep  3 15:52 hard-link.txt
1716238 lrwxrwxrwx 1 root root 12 Sep  3 15:52 soft-link.txt -> original.txt

$ cat soft-link.txt
cat: soft-link.txt: No such file or directory

$ cat hard-link.txt
This is the original file.

$ stat -c "%n | inode=%i | links=%h | size=%s" hard-link.txt
hard-link.txt | inode=1716237 | links=1 | size=27

### directories
$ ln mydir dir-hard-link
ln: mydir: hard link not allowed for directory

$ ln -s mydir dir-soft-link

$ ls -li
total 8
1716240 lrwxrwxrwx 1 root root    5 Sep  3 15:52 dir-soft-link -> mydir
1716237 -rw-r--r-- 1 root root   27 Sep  3 15:52 hard-link.txt
1716239 drwxr-xr-x 2 root root 4096 Sep  3 15:52 mydir
1716238 lrwxrwxrwx 1 root root   12 Sep  3 15:52 soft-link.txt -> original.txt
```

The inode column is the thing to look at. `original.txt` and `hard-link.txt` are both 1716237
with a link count of 2, so they really are one file with two names. The soft link has its own
inode and a count of 1. After `rm original.txt` the count drops to 1 and the data is still
readable through the hard link, while the soft link is left pointing at a name that no longer
exists.

If I get asked this in an interview: a hard link is another directory entry for the same
inode, a soft link is a small file containing a path. Hard links keep data alive until the
last name is gone, soft links break when the target does. In practice symlinks are what you
see in `/usr/bin` for version switching, and hard links show up in backup tools that want to
share unchanged files between snapshots without copying them.

---

## Task 2: `adduser` vs `useradd`

`useradd` is the low-level binary from the `shadow` package. `adduser` is a Perl script that
calls it and fills in everything Debian policy expects. You can see that with `file`:

```console
$ which useradd adduser
/usr/sbin/useradd
/usr/sbin/adduser

$ file /usr/sbin/useradd /usr/sbin/adduser
/usr/sbin/useradd: ELF 64-bit LSB pie executable, ARM aarch64, version 1 (SYSV), dynamically linked, interpreter /lib/ld-linux-aarch64.so.1, BuildID[sha1]=483f79642f7a936acdeb2cb2fd1c4e70c2f0ef9d, for GNU/Linux 3.7.0, stripped
/usr/sbin/adduser: Perl script text executable
```

On Ubuntu the recommended one is `adduser`, because one command gives you an account you can
actually use: home directory, dotfiles from `/etc/skel`, bash instead of sh, a password
prompt, and a UID from the right range. Bare `useradd` gives you a half-built account, which
is the classic beginner trap. `useradd` is still the better choice inside scripts, where you
want the same result every time and no prompts, and it exists on every distro.

Here are both, so the difference is visible:

```console
### low-level useradd with no options
$ useradd testuser-lowlevel

$ grep testuser-lowlevel /etc/passwd
testuser-lowlevel:x:1001:1001::/home/testuser-lowlevel:/bin/sh

$ ls -la /home
total 12
drwxr-xr-x 1 root   root   4096 Sep  3 15:53 .
drwxr-xr-x 1 root   root   4096 Sep  3 15:52 ..
drwxr-x--- 2 ubuntu ubuntu 4096 Aug 10 14:55 ubuntu

### the recommended way on Ubuntu
$ adduser --disabled-password --gecos "" testuser-kartavya
info: Adding user `testuser-kartavya' ...
info: Selecting UID/GID from range 1000 to 59999 ...
info: Adding new group `testuser-kartavya' (1002) ...
info: Adding new user `testuser-kartavya' (1002) with group `testuser-kartavya (1002)' ...
info: Creating home directory `/home/testuser-kartavya' ...
info: Copying files from `/etc/skel' ...
info: Adding new user `testuser-kartavya' to supplemental / extra groups `users' ...
info: Adding user `testuser-kartavya' to group `users' ...

$ ls -la /home/testuser-kartavya
total 20
drwxr-x--- 2 testuser-kartavya testuser-kartavya 4096 Sep  3 15:53 .
drwxr-xr-x 1 root              root              4096 Sep  3 15:53 ..
-rw-r--r-- 1 testuser-kartavya testuser-kartavya  220 Sep  3 15:53 .bash_logout
-rw-r--r-- 1 testuser-kartavya testuser-kartavya 3771 Sep  3 15:53 .bashrc
-rw-r--r-- 1 testuser-kartavya testuser-kartavya  807 Sep  3 15:53 .profile

$ getent passwd testuser-lowlevel testuser-kartavya
testuser-lowlevel:x:1001:1001::/home/testuser-lowlevel:/bin/sh
testuser-kartavya:x:1002:1002:,,,:/home/testuser-kartavya:/bin/bash

$ id testuser-kartavya
uid=1002(testuser-kartavya) gid=1002(testuser-kartavya) groups=1002(testuser-kartavya),100(users)

### cleanup
$ deluser --remove-home testuser-lowlevel
info: Looking for files to backup/remove ...
warn: `/usr/bin/crontab' not executed. Skipping crontab removal. Package `cron' required.
info: Removing user `testuser-lowlevel' ...
```

The `/etc/passwd` line for `testuser-lowlevel` claims a home of `/home/testuser-lowlevel`, but
`ls /home` shows it was never created, and the shell is `/bin/sh`. The `adduser` account has
a real home with `.bashrc` and `.profile` in it, `/bin/bash`, and membership in `users`.
I created my test user with `adduser`, using `--disabled-password --gecos ""` only so it
wouldn't stop for prompts. Normally you just run `adduser username` and answer them.

---

## Task 3: `journalctl`

`systemd-journald` collects the kernel log, early boot messages, and the stdout and stderr of
every systemd service into one indexed binary journal. `journalctl` reads it. Before systemd
you'd be grepping `/var/log/syslog`, `/var/log/messages` and each app's own log file, all in
different formats. Now it's one place you can filter by unit, time, priority or PID.

The ones I use:

```bash
journalctl -n 20                 # last 20 lines
journalctl -f                    # follow, like tail -f
journalctl -u nginx              # one service, the important one
journalctl -u nginx -n 15 -f     # last 15 for that service, then follow
journalctl -b                    # this boot only
journalctl -p err                # errors and worse
journalctl --since "10 min ago"
journalctl -k                    # kernel only
journalctl --disk-usage
```

I added `--no-pager` below so the output could be captured into this file.

```console
$ journalctl --no-pager -n 10
Sep 03 15:53:02 linux-lab chfn[541]: changed user 'testuser-kartavya' information
Sep 03 15:53:02 linux-lab adduser[517]: Adding new user `testuser-kartavya' to supplemental / extra groups `users' ...
Sep 03 15:53:02 linux-lab adduser[517]: Adding user `testuser-kartavya' to group `users' ...
Sep 03 15:53:02 linux-lab gpasswd[549]: members of group users set by root to testuser-kartavya
Sep 03 15:53:02 linux-lab deluser[561]: Looking for files to backup/remove ...
Sep 03 15:53:02 linux-lab deluser[561]: `/usr/bin/crontab' not executed. Skipping crontab removal. Package `cron' required.
Sep 03 15:53:02 linux-lab deluser[561]: Removing user `testuser-lowlevel' ...
Sep 03 15:53:02 linux-lab userdel[565]: delete user 'testuser-lowlevel'
Sep 03 15:53:02 linux-lab userdel[565]: removed group 'testuser-lowlevel' owned by 'testuser-lowlevel'
Sep 03 15:53:02 linux-lab userdel[565]: removed shadow group 'testuser-lowlevel' owned by 'testuser-lowlevel'

$ journalctl --disk-usage
Archived and active journals take up 8.0M in the file system.

$ systemctl start nginx

$ journalctl -u nginx --no-pager
Sep 03 15:53:20 linux-lab systemd[1]: Starting nginx.service - A high performance web server and a reverse proxy server...
Sep 03 15:53:20 linux-lab systemd[1]: Started nginx.service - A high performance web server and a reverse proxy server.

$ systemctl restart nginx

$ journalctl -u nginx --no-pager -n 15
Sep 03 15:53:20 linux-lab systemd[1]: Starting nginx.service - A high performance web server and a reverse proxy server...
Sep 03 15:53:20 linux-lab systemd[1]: Started nginx.service - A high performance web server and a reverse proxy server.
Sep 03 15:53:20 linux-lab systemd[1]: Stopping nginx.service - A high performance web server and a reverse proxy server...
Sep 03 15:53:20 linux-lab systemd[1]: nginx.service: Deactivated successfully.
Sep 03 15:53:20 linux-lab systemd[1]: Stopped nginx.service - A high performance web server and a reverse proxy server.
Sep 03 15:53:20 linux-lab systemd[1]: Starting nginx.service - A high performance web server and a reverse proxy server...
Sep 03 15:53:20 linux-lab systemd[1]: Started nginx.service - A high performance web server and a reverse proxy server.

$ journalctl -k --no-pager -n 5
Sep 03 15:52:11 linux-lab kernel: eth0: renamed from veth1a9cc9d
Sep 03 15:52:11 linux-lab kernel: docker0: port 3(veth74018b0) entered blocking state
Sep 03 15:52:11 linux-lab kernel: docker0: port 3(veth74018b0) entered forwarding state
Sep 03 15:52:11 linux-lab systemd-journald[29]: Collecting audit messages is disabled.
Sep 03 15:52:11 linux-lab systemd-journald[29]: Received client request to flush runtime journal.
```

A restart reads as Stopping, Deactivated, Stopped, Starting, Started, which is a useful shape
to recognise.

Reading logs from a service that works is not very interesting, so I wrote a unit that fails
on purpose and went looking for it. This is closer to what you actually do with journalctl:

```console
$ systemctl start broken-demo.service
Job for broken-demo.service failed because the control process exited with error code.
See "systemctl status broken-demo.service" and "journalctl -xeu broken-demo.service" for details.

$ journalctl -u broken-demo.service --no-pager
Sep 03 15:53:38 linux-lab systemd[1]: Starting broken-demo.service - Deliberately broken demo service...
Sep 03 15:53:38 linux-lab bash[664]: starting the demo job
Sep 03 15:53:38 linux-lab bash[664]: could not reach the database
Sep 03 15:53:38 linux-lab systemd[1]: broken-demo.service: Main process exited, code=exited, status=1/FAILURE
Sep 03 15:53:38 linux-lab systemd[1]: broken-demo.service: Failed with result 'exit-code'.
Sep 03 15:53:38 linux-lab systemd[1]: Failed to start broken-demo.service - Deliberately broken demo service.

$ journalctl -p err --no-pager -n 5
Sep 03 15:52:37 linux-lab deluser[194]: In order to use the --remove-home, --remove-all-files, and --backup features, you need to install the `perl' package. To accomplish that, run apt-get install perl.
Sep 03 15:53:38 linux-lab systemd[1]: Failed to start broken-demo.service - Deliberately broken demo service.

$ systemctl status broken-demo.service --no-pager
× broken-demo.service - Deliberately broken demo service
     Loaded: loaded (/etc/systemd/system/broken-demo.service; static)
     Active: failed (Result: exit-code) since Thu 2026-09-03 15:53:38 UTC; 9ms ago
    Process: 664 ExecStart=/bin/bash -c echo "starting the demo job"; echo "could not reach the database" >&2; exit 1 (code=exited, status=1/FAILURE)
   Main PID: 664 (code=exited, status=1/FAILURE)
        CPU: 1ms

Sep 03 15:53:38 linux-lab systemd[1]: Starting broken-demo.service - Deliberately broken demo service...
Sep 03 15:53:38 linux-lab bash[664]: starting the demo job
Sep 03 15:53:38 linux-lab bash[664]: could not reach the database
Sep 03 15:53:38 linux-lab systemd[1]: broken-demo.service: Main process exited, code=exited, status=1/FAILURE
Sep 03 15:53:38 linux-lab systemd[1]: broken-demo.service: Failed with result 'exit-code'.
Sep 03 15:53:38 linux-lab systemd[1]: Failed to start broken-demo.service - Deliberately broken demo service.
```

The part I didn't expect: my `echo` to stderr, "could not reach the database", is sitting in
the journal even though I never set up a log file for that service. journald captures a
unit's stdout and stderr automatically. `journalctl -p err` then finds that failure among
system-wide errors, which is how you work out what recently broke on a machine you've just
been handed. And `systemctl status` turns out to be a summary plus the last few journal lines
for the unit.

---

## Task 4: cheat sheet practice

One session working through the commands, grouped roughly by what they're for.

```console
==== where am I, who am I ====
$ pwd
/root/cheatsheet

$ whoami
root

$ id
uid=0(root) gid=0(root) groups=0(root)

$ uname -a
Linux linux-lab 7.0.12-linuxkit #1 SMP PREEMPT Wed Aug 12 20:18:49 UTC 2026 aarch64 aarch64 aarch64 GNU/Linux

$ uptime
 15:53:52 up  1:58,  0 user,  load average: 0.26, 0.22, 0.14

==== files and directories ====
$ mkdir -p project/src project/logs

$ tree project
project
|-- logs
`-- src

3 directories, 0 files

$ touch project/src/app.py project/src/utils.py

$ printf "line one\nline two\nline three\nERROR: disk full\nline five\n" > project/logs/app.log

$ cp project/logs/app.log project/logs/app.log.bak

$ mv project/src/utils.py project/src/helpers.py

$ ls -l project/src project/logs
project/logs:
total 8
-rw-r--r-- 1 root root 56 Sep  3 15:53 app.log
-rw-r--r-- 1 root root 56 Sep  3 15:53 app.log.bak

project/src:
total 0
-rw-r--r-- 1 root root 0 Sep  3 15:53 app.py
-rw-r--r-- 1 root root 0 Sep  3 15:53 helpers.py

$ rm project/logs/app.log.bak

==== reading files ====
$ cat project/logs/app.log
line one
line two
line three
ERROR: disk full
line five

$ head -2 project/logs/app.log
line one
line two

$ tail -2 project/logs/app.log
ERROR: disk full
line five

$ wc -l project/logs/app.log
5 project/logs/app.log

==== searching ====
$ grep "ERROR" project/logs/app.log
ERROR: disk full

$ grep -n "line" project/logs/app.log
1:line one
2:line two
3:line three
5:line five

$ grep -ri "error" project/
project/logs/app.log:ERROR: disk full

$ find project -name "*.py"
project/src/app.py
project/src/helpers.py

$ find project -type d
project
project/logs
project/src

==== permissions ====
$ echo "#!/bin/bash" > project/run.sh

$ ls -l project/run.sh
-rw-r--r-- 1 root root 12 Sep  3 15:53 project/run.sh

$ chmod +x project/run.sh

$ ls -l project/run.sh
-rwxr-xr-x 1 root root 12 Sep  3 15:53 project/run.sh

$ chmod 644 project/run.sh && ls -l project/run.sh
-rw-r--r-- 1 root root 12 Sep  3 15:53 project/run.sh

==== processes ====
$ ps aux | head -5
USER         PID %CPU %MEM    VSZ   RSS TTY      STAT START   TIME COMMAND
root           1  0.1  0.1  20956 11592 ?        Ss   15:52   0:00 /sbin/init
root          29  0.0  0.1  33700 11412 ?        S<s  15:52   0:00 /usr/lib/systemd/systemd-journald
message+     335  0.0  0.0   9512  4428 ?        Ss   15:53   0:00 @dbus-daemon --system --address=systemd: --nofork --nopidfile --systemd-activation --syslog-only
root         338  0.0  0.0  17268  7152 ?        Ss   15:53   0:00 /usr/lib/systemd/systemd-logind

$ sleep 300 & echo "started background sleep with PID $!"
started background sleep with PID 713

$ pgrep -a sleep
713 sleep 300

$ kill $(pgrep sleep) && echo "killed it"
killed it

$ pgrep -a sleep || echo "no sleep process left"
no sleep process left

==== disk and memory ====
$ df -h /
Filesystem      Size  Used Avail Use% Mounted on
overlay         911G  136G  729G  16% /

$ du -sh /root/cheatsheet
24K	/root/cheatsheet

$ free -h
               total        used        free      shared  buff/cache   available
Mem:           7.7Gi       1.8Gi       118Mi        59Mi       6.1Gi       6.0Gi
Swap:          1.0Gi          0B       1.0Gi

==== text pipeline ====
$ printf "banana\napple\ncherry\napple\nbanana\napple\n" > fruits.txt

$ sort fruits.txt | uniq -c | sort -rn
      3 apple
      2 banana
      1 cherry

$ cut -d: -f1 /etc/passwd | head -5
root
daemon
bin
sys
sync

$ awk -F: "{print \$1, \$7}" /etc/passwd | head -5
root /bin/bash
daemon /usr/sbin/nologin
bin /usr/sbin/nologin
sys /usr/sbin/nologin
sync /bin/sync

$ sed "s/apple/AVOCADO/g" fruits.txt
banana
AVOCADO
cherry
AVOCADO
banana
AVOCADO

==== archiving ====
$ tar -czf project.tar.gz project

$ tar -tzf project.tar.gz
project/
project/logs/
project/logs/app.log
project/run.sh
project/src/
project/src/app.py
project/src/helpers.py

==== lookup ====
$ which grep
/usr/bin/grep

$ type cd
cd is a shell builtin

$ echo $PATH
/usr/local/sbin:/usr/local/bin:/usr/sbin:/usr/bin:/sbin:/bin
```

Things I want to remember out of that:

`find` searches for files by name or type, `grep` searches inside them. I keep mixing those
up. `grep -rn` is the one I use most.

`sort | uniq -c | sort -rn` counts and ranks. `uniq` only collapses adjacent duplicates, so
the first `sort` isn't optional.

`df` is free space per filesystem, `du` is space used by a directory. Disk full means `df -h`
to find the mount, then `du -sh *` to find the folder.

`chmod 644` and `chmod u=rw,go=r` do the same thing. 6 is `rw-`, 4 is `r--`.

`kill` sends a signal rather than always killing. The default is TERM, which asks politely.
`kill -9` is KILL and can't be caught, so it's the last resort.
