# Docker Networking & Volumes

**Name:** Kartavya Panchal
**Roll No.:** 24BCS10343

```
07-docker-networking/
├── site/index.html      the file bind-mounted into nginx in Task 3
├── screenshots/
└── README.md
```

---

## Task 1: container networking

Three containers: `frontend` on nginx, `backend` on alpine, `database` on mysql:8.0. Three
networks: `frontend-net`, `backend-net`, `isolated-net`. The backend joins two of them, which
is what lets it talk to both sides while the frontend and database can't reach each other.
That's the usual three-tier arrangement, with the database kept away from the web tier.

```
   frontend-net                 backend-net
 ┌──────────────┐            ┌──────────────┐
 │   frontend   │            │   database   │
 │  (nginx)     │            │  (mysql:8.0) │
 └──────┬───────┘            └──────┬───────┘
        │                           │
        └────────► backend ◄────────┘
              (on BOTH networks)
```

```console
==================== create 3 networks ====================
$ docker network create frontend-net
3dd566dca27f5cac8ed3126295680a41747a43e5e6e874037e8e92d72e704baa

$ docker network create backend-net
2acbbd04d141b46af5e07b2c8b776f31dcc1c2999dc1f47fa18822eed889162f

$ docker network create isolated-net
1cb2010e632c77f421ab5d6ec5b86bed17af96146e122c9e7afa84cf9f17fd6f

$ docker network ls
NETWORK ID     NAME           DRIVER    SCOPE
2acbbd04d141   backend-net    bridge    local
9cafa7e508ad   bridge         bridge    local
3dd566dca27f   frontend-net   bridge    local
1834b9e251c3   host           host      local
1cb2010e632c   isolated-net   bridge    local
7260248927de   none           null      local
3ed539200051   qc_default     bridge    local

==================== create the 3 containers ====================
$ docker run -d --name frontend --network frontend-net -p 8084:80 nginx:alpine
bee012ed045fde5653ea8d51b7727c02b06194bca97f7482a21cf648c76f410b

# alpine exits immediately unless you give it something to do, hence sleep infinity
$ docker run -d --name backend --network frontend-net alpine:3.20 sleep infinity
e075806d0d4a2ed175a2b2444302560d9cd53d232fb5ecc066f476c6ca654eb7

$ docker run -d --name database --network backend-net -e MYSQL_ROOT_PASSWORD=rootpass -e MYSQL_DATABASE=appdb mysql:8.0
a5fdb14c3f23adc4ed8c210ee3e3b9f09b040e66b68488a0559bee7300401249

==================== put backend on a second network ====================
$ docker network connect backend-net backend

$ docker inspect backend --format '{{range $k,$v := .NetworkSettings.Networks}}{{$k}} -> {{$v.IPAddress}}{{"\n"}}{{end}}'
backend-net -> 172.20.0.3
frontend-net -> 172.19.0.3

==================== who is on what ====================
$ docker network inspect frontend-net --format 'frontend-net: {{range .Containers}}{{.Name}} ({{.IPv4Address}}) {{end}}'
frontend-net: frontend (172.19.0.2/16) backend (172.19.0.3/16) 

$ docker network inspect backend-net --format 'backend-net: {{range .Containers}}{{.Name}} ({{.IPv4Address}}) {{end}}'
backend-net: database (172.20.0.2/16) backend (172.20.0.3/16) 

$ docker network inspect isolated-net --format 'isolated-net: {{range .Containers}}{{.Name}} ({{.IPv4Address}}) {{end}}'
isolated-net: 

==================== connectivity ====================
$ docker exec backend apk add --no-cache curl iputils >/dev/null 2>&1 && echo 'tools installed in backend'
tools installed in backend

--- frontend to backend, both on frontend-net ---
$ docker exec frontend ping -c 3 backend
PING backend (172.19.0.3) 56(84) bytes of data.
64 bytes from backend.frontend-net (172.19.0.3): icmp_seq=1 ttl=64 time=0.465 ms
64 bytes from backend.frontend-net (172.19.0.3): icmp_seq=2 ttl=64 time=0.145 ms
64 bytes from backend.frontend-net (172.19.0.3): icmp_seq=3 ttl=64 time=0.185 ms

--- backend ping statistics ---
3 packets transmitted, 3 received, 0% packet loss, time 2079ms

$ docker exec backend curl -s -o /dev/null -w 'frontend HTTP status: %{http_code}\n' http://frontend
frontend HTTP status: 200

--- backend to database, both on backend-net ---
$ docker exec backend ping -c 3 database
PING database (172.20.0.2) 56(84) bytes of data.
64 bytes from database.backend-net (172.20.0.2): icmp_seq=1 ttl=64 time=0.107 ms
64 bytes from database.backend-net (172.20.0.2): icmp_seq=2 ttl=64 time=0.166 ms
64 bytes from database.backend-net (172.20.0.2): icmp_seq=3 ttl=64 time=0.202 ms

--- database ping statistics ---
3 packets transmitted, 3 received, 0% packet loss, time 2033ms

$ docker exec database sh -c 'until mysqladmin ping -uroot -prootpass --silent 2>/dev/null; do sleep 2; done; echo MySQL is ready'
mysqld is alive
MySQL is ready

$ docker exec backend nc -zv database 3306
Connection to database (172.20.0.2) 3306 port [tcp/mysql] succeeded!

# an actual query, from a throwaway client container on backend-net
$ docker run --rm --network backend-net mysql:8.0 mysql -h database -uroot -prootpass -e 'SELECT VERSION() AS mysql_version; SHOW DATABASES;' 2>/dev/null
mysql_version
8.0.46
Database
appdb
information_schema
mysql
performance_schema
sys

--- frontend to database, no shared network ---
$ docker exec frontend ping -c 2 database
ping: database: Name does not resolve

$ docker exec frontend nc -zv -w 3 database 3306
nc: getaddrinfo for host "database" port 3306: Name does not resolve

==================== is it really the network membership? ====================
# isolated-net first. database is not on it, so nothing should change
$ docker network connect isolated-net frontend

$ docker exec frontend ping -c 2 database
ping: database: Name does not resolve

# now backend-net, which database IS on
$ docker network connect backend-net frontend

$ docker exec frontend ping -c 3 database
PING database (172.20.0.2) 56(84) bytes of data.
64 bytes from database.backend-net (172.20.0.2): icmp_seq=1 ttl=64 time=0.639 ms
64 bytes from database.backend-net (172.20.0.2): icmp_seq=2 ttl=64 time=0.214 ms
64 bytes from database.backend-net (172.20.0.2): icmp_seq=3 ttl=64 time=0.098 ms

--- database ping statistics ---
3 packets transmitted, 3 received, 0% packet loss, time 2045ms

$ docker network disconnect backend-net frontend

$ docker exec frontend ping -c 2 database
ping: database: Name does not resolve
```

![frontend nginx on port 8084](screenshots/frontend-nginx-8084.png)

So frontend and backend reach each other, backend reaches the database well enough to run a
real query against MySQL 8.0.46, and frontend can't see the database at all.

The container names working as hostnames is the part that surprised me. Docker runs a DNS
server at `127.0.0.11` inside each container and it answers for containers sharing a network.
It only does this on user-defined networks, not the default `bridge`, which is a good enough
reason on its own to always make your own network.

Isolation being the default is the other thing worth noticing. `frontend` didn't time out
trying to reach `database`, it got `Name does not resolve`. The name doesn't exist for it,
because Docker's DNS only hands back entries for networks you share. I didn't have to firewall
anything.

The last block is the bit I added to convince myself the network membership was really the
cause and not something else. Connecting `frontend` to `isolated-net` changed nothing, since
the database isn't there. Connecting it to `backend-net` made `ping database` work instantly,
with no restart, and disconnecting broke it again. Being on more networks doesn't help; you
need a shared one. Also visible in the output: a container gets one IP per network, so
`backend` holds both `172.19.0.3` and `172.20.0.3`.

---

## Task 2: host network

```console
==================== pull apache ====================
$ docker pull httpd:2.4
2.4: Pulling from library/httpd
Digest: sha256:979c38c2228d28c2edfd45c6e27dcee1c7b4a101a5526721ae8ece454e89e99e
Status: Image is up to date for httpd:2.4
docker.io/library/httpd:2.4

==================== run it on the host network ====================
# no -p flag, that is the whole point
$ docker run -d --name apache-host --network host httpd:2.4
cd26e583be78e6153ac9cf4f348bdc256a2ae571ec9372e003c483200227b033

$ docker ps --filter name=apache-host --format 'table {{.Names}}\t{{.Image}}\t{{.Status}}\t{{.Ports}}\t{{.Networks}}'
NAMES         IMAGE       STATUS                  PORTS     NETWORKS
apache-host   httpd:2.4   Up Less than a second             host

$ docker inspect apache-host --format 'NetworkMode = {{.HostConfig.NetworkMode}}'
NetworkMode = host

$ docker inspect apache-host --format 'PortBindings = {{.HostConfig.PortBindings}}'
PortBindings = map[]

$ docker inspect apache-host --format 'Networks = {{range $k,$v := .NetworkSettings.Networks}}{{$k}} (IPAddress=[{{$v.IPAddress}}]){{end}}'
Networks = host (IPAddress=[invalid IP])

# the hostname it reports is the host's own
$ docker exec apache-host hostname
docker-desktop

==================== reach it on port 80 ====================
$ docker run --rm --network host alpine:3.20 sh -c 'apk add --no-cache curl >/dev/null 2>&1; curl -s http://localhost:80'
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01//EN" "http://www.w3.org/TR/html4/strict.dtd">
<html>
<head>
<title>It works! Apache httpd</title>
</head>
<body>
<p>It works!</p>
</body>
</html>

$ docker run --rm --network host alpine:3.20 sh -c 'apk add --no-cache busybox-extras >/dev/null 2>&1; netstat -tln | grep ":80 "'
tcp        0      0 :::80                   :::*                    LISTEN      

==================== the same request from macOS ====================
$ curl -s -m 5 -o /dev/null -w 'from macOS: HTTP status %{http_code} (000 = could not connect)\n' http://localhost:80
from macOS: HTTP status 000 (000 = could not connect)

==================== compare against a bridge container ====================
$ docker run -d --name apache-bridge -p 8086:80 httpd:2.4
f5f579152c3180c5e41d5b3360b2794dc8b4e9cf30aabde6455fdd0ce41e38f4

$ docker ps --filter name=apache-bridge --format 'table {{.Names}}\t{{.Status}}\t{{.Ports}}\t{{.Networks}}'
NAMES           STATUS                  PORTS                                     NETWORKS
apache-bridge   Up Less than a second   0.0.0.0:8086->80/tcp, [::]:8086->80/tcp   bridge

$ docker inspect apache-bridge --format 'NetworkMode={{.HostConfig.NetworkMode}}  ContainerIP={{range .NetworkSettings.Networks}}{{.IPAddress}}{{end}}'
NetworkMode=bridge  ContainerIP=172.17.0.13

$ curl -s -o /dev/null -w 'bridge + published port, from macOS: HTTP %{http_code}\n' http://localhost:8086
bridge + published port, from macOS: HTTP 200
```

![Apache on port 8086](screenshots/apache-bridge-8086.png)

`--network host` means the container doesn't get its own network namespace, it shares the
host's. Everything else follows from that. No `-p` was needed, `docker ps` shows an empty
PORTS column, `PortBindings` is an empty map, the container has no IP of its own, and
`hostname` inside it returns `docker-desktop`, which is the host's. Apache is listening on
port 80 directly in that namespace and returns its "It works!" page there. The bridge
container next to it had to be given `-p 8086:80` and got its own IP, `172.17.0.13`.

What you trade: no NAT layer, so it's a bit faster and the app can see real client IPs, which
matters for some servers. Against that, you lose isolation, you can't run two containers that
both want port 80, and container-name DNS is gone.

One thing I should be upfront about. I'm on macOS, and Docker Desktop runs containers inside a
Linux VM, so `--network host` shares the *VM's* namespace and not macOS's. That's why curling
`localhost:80` works from a container in the host namespace and returns `000` from my own
terminal. On a real Linux host, `curl http://localhost:80` from the host shell returns the
Apache page with no mapping at all, which is the result the task is describing. Newer Docker
Desktop has an opt-in host-networking setting, but turning it on needs a restart of Docker
Desktop and I had other containers running I didn't want to kill. So the `--network host`
behaviour itself is shown as fully as the platform allows, and the one part that's a macOS
limitation rather than a result is called out here.

---

## Task 3: bind mount

```console
$ cat site/index.html
<!doctype html>
<html>
  <head><title>Bind mount demo</title></head>
  <body>
    <h1>Hello students</h1>
  </body>
</html>

$ docker run -d --name nginx-bind -p 8085:80 -v '/Users/kp/SST/3rd Year/Devops/SST-Assignments/my-devops-homework/07-docker-networking/site':/usr/share/nginx/html:ro nginx:alpine
8ec3b2f24d65f0d65d6b170f77259a35e2fce0ccc237fce4f5abafc7b548cc0b

$ docker inspect nginx-bind --format '{{range .Mounts}}Type={{.Type}}{{"\n"}}Source={{.Source}}{{"\n"}}Destination={{.Destination}}{{"\n"}}ReadOnly={{.RW | not}}{{end}}'
Type=bind
Source=/Users/kp/SST/3rd Year/Devops/SST-Assignments/my-devops-homework/07-docker-networking/site
Destination=/usr/share/nginx/html
ReadOnly=true

$ docker exec nginx-bind ls -l /usr/share/nginx/html
total 4
-rw-r--r--    1 root     root           124 Sep  3 16:38 index.html

$ curl -s http://localhost:8085
<!doctype html>
<html>
  <head><title>Bind mount demo</title></head>
  <body>
    <h1>Hello students</h1>
  </body>
</html>

==================== now edit the file on the host ====================
$ sed -i '' 's|<h1>Hello students</h1>|<h1>Hello students - this line was edited on the host at 22:08:01</h1>\n    <p>The container was NEVER restarted.</p>|' site/index.html

$ curl -s http://localhost:8085
<!doctype html>
<html>
  <head><title>Bind mount demo</title></head>
  <body>
    <h1>Hello students - this line was edited on the host at 22:08:01</h1>
    <p>The container was NEVER restarted.</p>
  </body>
</html>

$ docker inspect nginx-bind --format 'StartedAt={{.State.StartedAt}}  RestartCount={{.RestartCount}}  Running={{.State.Running}}'
StartedAt=2026-09-03T16:38:01.531081712Z  RestartCount=0  Running=true

==================== :ro means the container cannot write ====================
$ docker exec nginx-bind sh -c 'echo hacked > /usr/share/nginx/html/index.html'
sh: can't create /usr/share/nginx/html/index.html: Read-only file system
```

![Bind mounted nginx](screenshots/bind-mount-nginx.png)

`-v /host/path:/container/path` puts a folder from my laptop straight into the container, and
`docker inspect` confirms `Type=bind` with my real project path as the source. The container
isn't given a copy, it's the same file, which is why editing `site/index.html` in my editor
changed what nginx served on the next request with no rebuild and no restart. `RestartCount=0`
and the unchanged `StartedAt` are there to prove the container really wasn't restarted.

This is why bind mounts are how people develop inside containers: save the file, refresh the
browser. I added `:ro` so the container can't write back, and trying to anyway failed with
`Read-only file system`. That's a sensible default for static content, since a compromised web
server then can't rewrite the pages it's serving.

The other option is a named volume, `-v myvolume:/container/path`, where Docker manages the
storage itself under `/var/lib/docker/volumes` and you don't touch it directly from the host.
The way I think about the choice: bind mount when I need to see and edit the files, named
volume when the container owns the data and just needs it to survive being recreated. So bind
mounts for development and config, named volumes for database files and uploads.

---

## Task 4: overlay networks (research)

This one was to research rather than build, since an overlay needs more than one Docker host.

A bridge network connects containers on one host. An overlay connects them across many hosts,
so containers on different physical machines act like they're on the same private LAN. It's
the driver Docker Swarm uses, and the same idea sits underneath Kubernetes pod networking.

The mechanism is VXLAN encapsulation. Each container packet gets wrapped in a UDP packet on
port 4789 addressed host to host, sent over the physical network, and unwrapped at the far end.
The container never knows, it thinks it sent an ordinary packet to a neighbour. A network
running on top of another network is where the name overlay comes from.

For that to work the cluster needs to agree on who is where, so swarm managers keep a shared
key-value store using Raft consensus recording which container holds which overlay IP on which
host. On top of that sits cluster-wide DNS, so a service name resolves from any node, and the
name actually resolves to a virtual IP with the routing mesh spreading requests across every
replica wherever they happen to run. `--opt encrypted` adds IPsec between hosts, which matters
if the traffic crosses a network you don't control.

Setting one up:

```bash
# on the manager
docker swarm init --advertise-addr <manager-ip>
docker network create -d overlay --attachable my-overlay

# on each worker
docker swarm join --token <token> <manager-ip>:2377

# deploy across the cluster
docker service create --name web --network my-overlay --replicas 5 nginx:alpine
```

`--attachable` is what lets an ordinary `docker run --network my-overlay` container join,
rather than only swarm services.

Where you'd want one: an app whose web, API and worker tiers are spread over several machines
but still address each other by name; scaling past what a single host can hold without
rewriting any addresses; staying up when a host dies, because swarm reschedules elsewhere and
the service name still resolves; and keeping unrelated stacks on shared hardware from seeing
each other by giving each its own overlay.

Two practical gotchas I found worth writing down. The hosts need TCP 2377 for cluster
management, TCP and UDP 7946 for node discovery, and UDP 4789 for the VXLAN data, and overlay
networks fail quietly if those are blocked. And VXLAN adds about 50 bytes of header, so an MTU
mismatch shows up as small requests working fine while large ones hang, which sounds like an
awful thing to debug without knowing that in advance.

For reference, the drivers I've now touched: `bridge` for containers on one host, which is
Task 1 and the default; `host` for one host with no isolation and no port mapping, Task 2;
`overlay` for multiple hosts in a swarm; `macvlan`, where a container gets an address on the
physical LAN as though it were its own device, for legacy software that expects that; and
`none` for no networking at all.

---

## Cleanup

```bash
docker rm -f frontend backend database apache-host apache-bridge nginx-bind
docker network rm frontend-net backend-net isolated-net
```
