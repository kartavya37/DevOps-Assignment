# Networking Fundamentals

**Name:** Kartavya Panchal
**Roll No.:** 24BCS10343

Commands, their real output, and what I took away from each.

Task 1 mentions practising from the shared `devops-hero` repo. I didn't have access to it, so
I worked through the networking commands covered in the session instead. If the repo has
extras, they can be added here in the same format.

Run on Linux (Ubuntu 24.04 in a container) because `ip`, `ss` and `traceroute` are Linux
tools. macOS ships `ifconfig` and `netstat` instead.

---

## 1. What machine am I on

```console
$ hostname
linux-lab

$ hostname -I
172.17.0.4 
```

The first thing to run after SSHing into a server you don't recognise. Name, then address.

---

## 2. Interfaces and addresses

```console
$ ip -br a
lo               UNKNOWN        127.0.0.1/8 ::1/128 
tunl0@NONE       DOWN           
gre0@NONE        DOWN           
gretap0@NONE     DOWN           
erspan0@NONE     DOWN           
ip_vti0@NONE     DOWN           
ip6_vti0@NONE    DOWN           
sit0@NONE        DOWN           
ip6tnl0@NONE     DOWN           
ip6gre0@NONE     DOWN           
eth0@if62        UP             172.17.0.4/16 

$ ip a
1: lo: <LOOPBACK,UP,LOWER_UP> mtu 65536 qdisc noqueue state UNKNOWN group default qlen 1000
    link/loopback 00:00:00:00:00:00 brd 00:00:00:00:00:00
    inet 127.0.0.1/8 scope host lo
       valid_lft forever preferred_lft forever
    inet6 ::1/128 scope host 
       valid_lft forever preferred_lft forever
11: eth0@if62: <BROADCAST,MULTICAST,UP,LOWER_UP> mtu 65535 qdisc noqueue state UP group default 
    link/ether 52:8f:48:ee:c4:34 brd ff:ff:ff:ff:ff:ff link-netnsid 0
    inet 172.17.0.4/16 brd 172.17.255.255 scope global eth0
       valid_lft forever preferred_lft forever
(trimmed the tunnel interfaces, all DOWN)

$ ifconfig eth0
eth0: flags=4163<UP,BROADCAST,RUNNING,MULTICAST>  mtu 65535
        inet 172.17.0.4  netmask 255.255.0.0  broadcast 172.17.255.255
        ether 52:8f:48:ee:c4:34  txqueuelen 0  (Ethernet)
        RX packets 2299  bytes 45576019 (45.5 MB)
        RX errors 0  dropped 0  overruns 0  frame 0
        TX packets 1317  bytes 93388 (93.3 KB)
        TX errors 0  dropped 0 overruns 0  carrier 0  collisions 0
```

`lo` is loopback, how the machine talks to itself. `eth0` is the one carrying the address
other machines actually reach. I've started using `ip -br a` by default since the full `ip a`
buries the one interface I care about under ten dead tunnel devices. `ifconfig` is the old
tool `ip` replaced; still works, deprecated.

---

## 3. Routing

```console
$ ip route
default via 172.17.0.1 dev eth0 
172.17.0.0/16 dev eth0 proto kernel scope link src 172.17.0.4 

$ ip route get 8.8.8.8
8.8.8.8 via 172.17.0.1 dev eth0 src 172.17.0.4 uid 0 
    cache 
```

The `default via` line is the gateway: anything not on the local subnet gets handed to it.
`ip route get` is the more useful of the two, since it answers the question directly for one
destination instead of making you read the table and work it out.

---

## 4. ping

```console
$ ping -c 4 8.8.8.8
PING 8.8.8.8 (8.8.8.8) 56(84) bytes of data.
64 bytes from 8.8.8.8: icmp_seq=1 ttl=63 time=12.8 ms
64 bytes from 8.8.8.8: icmp_seq=2 ttl=63 time=13.4 ms
64 bytes from 8.8.8.8: icmp_seq=3 ttl=63 time=51.7 ms
64 bytes from 8.8.8.8: icmp_seq=4 ttl=63 time=85.5 ms

--- 8.8.8.8 ping statistics ---
4 packets transmitted, 4 received, 0% packet loss, time 3017ms
rtt min/avg/max/mdev = 12.810/40.844/85.489/30.219 ms

$ ping -c 3 google.com
PING google.com (142.250.206.14) 56(84) bytes of data.
64 bytes from pnmaaa-ax-in-f14.1e100.net (142.250.206.14): icmp_seq=1 ttl=63 time=12.3 ms
64 bytes from pnmaaa-ax-in-f14.1e100.net (142.250.206.14): icmp_seq=2 ttl=63 time=27.2 ms
64 bytes from pnmaaa-ax-in-f14.1e100.net (142.250.206.14): icmp_seq=3 ttl=63 time=75.3 ms

--- google.com ping statistics ---
3 packets transmitted, 3 received, 0% packet loss, time 2008ms
rtt min/avg/max/mdev = 12.327/38.263/75.278/26.866 ms
```

ICMP echo requests, timed. The trick I want to remember: ping an IP and then ping a name. If
the IP answers and the name doesn't, it's DNS, not the network. That one comparison saves a
lot of guessing.

---

## 5. traceroute

```console
$ traceroute -m 8 google.com
traceroute to google.com (142.250.206.14), 8 hops max, 60 byte packets
 1  172.17.0.1 (172.17.0.1)  0.080 ms  0.011 ms  0.012 ms
 2  * * *
 3  * * *
 4  * * *
 5  * * *
 6  * * *
 7  * * *
 8  * * *
```

Every router on the way to the destination, with timings. It gets them by sending packets
with a TTL of 1, then 2, then 3, so each router in turn has to send back an expiry message.
Tells you *where* a path breaks rather than just that it did. The `* * *` hops are routers
that don't reply to the probes, which is normal and not a fault. Here only hop 1 answered,
since Docker Desktop's network stack hides the rest.

---

## 6. DNS

```console
$ nslookup google.com
Server:		192.168.65.7
Address:	192.168.65.7#53

Non-authoritative answer:
Name:	google.com
Address: 142.250.206.14

$ dig +short github.com
20.207.73.82

$ dig github.com A +noall +answer
github.com.		43	IN	A	20.207.73.82

$ cat /etc/resolv.conf
# Generated by Docker Engine.
# This file can be edited; Docker Engine will not make further changes once it
# has been modified.

nameserver 192.168.65.7
```

`nslookup` shows which server answered as well as the answer. `dig +short` gives just the
address, which is the one to use in a script. `/etc/resolv.conf` is where the machine's DNS
servers are actually listed, so it's the file to check when resolution is broken.

---

## 7. Listening sockets

```console
$ ss -tuln
Netid State  Recv-Q Send-Q Local Address:Port Peer Address:PortProcess
tcp   LISTEN 0      511          0.0.0.0:80        0.0.0.0:*          
tcp   LISTEN 0      511             [::]:80           [::]:*          

$ ss -tulnp
Netid State  Recv-Q Send-Q Local Address:Port Peer Address:PortProcess
tcp   LISTEN 0      511          0.0.0.0:80        0.0.0.0:*    users:(("nginx",pid=629,fd=5),("nginx",pid=628,fd=5),("nginx",pid=627,fd=5), ... )
tcp   LISTEN 0      511             [::]:80           [::]:*    users:(("nginx",pid=629,fd=6),("nginx",pid=628,fd=6),("nginx",pid=627,fd=6), ... )

$ netstat -tuln | head -4
Active Internet connections (only servers)
Proto Recv-Q Send-Q Local Address           Foreign Address         State      
tcp        0      0 0.0.0.0:80              0.0.0.0:*               LISTEN     
tcp6       0      0 :::80                   :::*                    LISTEN     
```

`-t` TCP, `-u` UDP, `-l` listening only, `-n` numeric ports. This is what you run when
something says "address already in use", and `-p` then names the process holding the port.
I trimmed the process list above, nginx had 16 workers all sharing the same socket, which is
itself worth knowing: the master binds port 80 once and the workers inherit the fd.

---

## 8. HTTP from the terminal

```console
$ curl -s -I https://github.com
HTTP/2 200 
date: Thu, 03 Sep 2026 15:54:41 GMT
content-type: text/html; charset=utf-8
content-language: en-US
etag: W/"ea9589011f7b4c03455f25134a51d04d"
cache-control: max-age=0, private, must-revalidate
strict-transport-security: max-age=31536000; includeSubdomains; preload
x-frame-options: deny
x-content-type-options: nosniff
referrer-policy: origin-when-cross-origin, strict-origin-when-cross-origin
server: github.com
x-github-request-id: C395:3C9B1F:52164D:587C79:6A99984A
x-github-edge-region: centralindia
(cut the content-security-policy and set-cookie lines, they run to several hundred characters)

$ curl -s https://api.github.com/zen
Responsive is better than fast.

$ curl -s -o /dev/null -w "http_code=%{http_code} time_total=%{time_total}s\n" https://www.google.com
http_code=200 time_total=0.218495s

$ wget -q -O /tmp/page.html https://example.com && ls -l /tmp/page.html && head -5 /tmp/page.html
-rw-r--r-- 1 root root 559 Sep  2 22:14 /tmp/page.html
<!doctype html><html lang="en"><head><title>Example Domain</title><link rel="icon" href="data:,"><meta name="viewport" content="width=device-width, initial-scale=1"><style>body{background:#eee;width:60vw;margin:15vh auto;font-family:system-ui,sans-serif}h1{font-size:1.5em}div{opacity:0.8}a:link,a:visited{color:#348}</style></head><body><div><h1>Example Domain</h1><p>This domain is for use in documentation examples without needing permission. Avoid use in operations.</p><p><a href="https://iana.org/domains/example">Learn more</a></p></div></body></html>
```

`-I` fetches headers only, which is enough to tell whether a service is alive. The `-w` flag
was new to me: you pick variables like `%{http_code}` and `%{time_total}` and curl prints
them, so with `-o /dev/null` you get a health check and a latency number in one line. `wget`
is the one aimed at saving files to disk instead.

---

## 9. Open connections

```console
$ curl -s -m 5 -o /dev/null -w "port 443 reachable, code=%{http_code}\n" https://github.com
port 443 reachable, code=200

$ ss -tn state established | head -5
Recv-Q Send-Q Local Address:Port Peer Address:PortProcess
```

`curl` with `-m` is a faster port check than telnet. `ss -tn state established` lists what's
currently connected, which was empty here since nothing was mid-request.

---

## 10. ARP table

```console
$ ip neigh
172.17.0.1 dev eth0 lladdr 32:e3:89:4f:20:9c REACHABLE 
```

IP to MAC mappings the machine has learned. Only covers the local segment, so anything past
the gateway never shows up here. That surprised me at first, but it follows from ARP being a
link-layer thing.

---

## The order I'd debug in

`ip a` to check I have an address at all, `ip route` for a gateway, ping the gateway, then
ping `8.8.8.8` for raw internet, then ping a hostname to test DNS. If step four works and
step five doesn't, it's DNS. Then `ss -tuln` and `curl -I` to check the service itself is up
on the port I expect.

Each step rules out one layer, so instead of "the internet is broken" you end up with a
specific thing that's broken.
