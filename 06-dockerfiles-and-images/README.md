# Dockerfiles & Images: multi-stage build

**Name:** Kartavya Panchal
**Roll No.:** 24BCS10343

Task 1 says to clone the repo holding the multi-stage Dockerfile. I didn't have that link, so I
wrote the equivalent app and multi-stage Dockerfile myself, in Go, serving the required
"Hello World from Docker multi-stage build" on port 8080. If the course repo is meant to be
used instead, swap in `git clone <url>` and every command below still applies.

```
06-dockerfiles-and-images/
├── main.go                   the web app, serves the message on :8080
├── go.mod
├── Dockerfile                the multi-stage build
├── Dockerfile.singlestage    same app built the naive way, for comparison
├── screenshots/
└── README.md
```

## Task 1: run the multi-stage Dockerfile

```dockerfile
# stage 1: compile. This stage carries the whole Go toolchain, ~250 MB of it.
FROM golang:1.22-alpine AS builder

WORKDIR /src

COPY go.mod ./
COPY main.go ./

# CGO_ENABLED=0 gives a static binary, so the final image needs no C library
RUN CGO_ENABLED=0 GOOS=linux go build -ldflags="-s -w" -o /out/server main.go

# stage 2: scratch is an entirely empty base image
FROM scratch

# only the binary crosses over. Compiler, source and module cache stay behind.
COPY --from=builder /out/server /server

EXPOSE 8080

ENTRYPOINT ["/server"]
```

A multi-stage Dockerfile has more than one `FROM`. Each one starts a fresh image and
everything from the stage before is discarded unless you name it in a `COPY --from=`.

The reason to bother is that the tools needed to build software aren't the tools needed to run
it. Compiling Go needs the toolchain. Running the result needs one static binary and literally
nothing else, not even a shell. So stage one does the compile in `golang:1.22-alpine`, and
stage two starts from `scratch` and copies across a single file.

```bash
docker build -t multistage-app:1.0 .
docker run -d --name multistage-app -p 8091:8080 multistage-app:1.0
curl http://localhost:8091
docker ps
```

```console
==================== build the multi-stage image ====================
$ docker build -t multistage-app:1.0 .
#5 [builder 1/5] FROM docker.io/library/golang:1.22-alpine@sha256:1699c10032ca2582ec89a24a1312d986a3f094aed3d5c1147b19880afe40e052
#5 DONE 11.1s
#6 [builder 2/5] WORKDIR /src
#6 DONE 0.2s
#7 [builder 3/5] COPY go.mod ./
#7 DONE 0.0s
#8 [builder 4/5] COPY main.go ./
#8 DONE 0.0s
#9 [builder 5/5] RUN CGO_ENABLED=0 GOOS=linux go build -ldflags="-s -w" -o /out/server main.go
#9 DONE 2.6s
#10 [stage-1 1/1] COPY --from=builder /out/server /server
#10 DONE 0.0s
#11 naming to docker.io/library/multistage-app:1.0 done
#11 DONE 0.2s

==================== and the single-stage one, to compare ====================
$ docker build -f Dockerfile.singlestage -t singlestage-app:1.0 .
#10 naming to docker.io/library/singlestage-app:1.0 done

$ docker images --format 'table {{.Repository}}\t{{.Tag}}\t{{.Size}}' | grep -E 'multistage-app|singlestage-app'
singlestage-app    1.0    436MB
multistage-app     1.0    6.53MB

==================== run it ====================
# host 8080 was already taken on my laptop, so I published to 8091.
# the app still listens on 8080 inside the container.
$ docker run -d --name multistage-app -p 8091:8080 multistage-app:1.0
7d0933bff7cc54fa0c62ac4a86c62851def435022972d1f15d8e31068bf3cb7f

$ docker logs multistage-app
2026/09/03 16:33:13 listening on :8080

$ curl -s http://localhost:8091
<h1>Hello World from Docker multi-stage build</h1>

$ curl -s -o /dev/null -w 'HTTP status: %{http_code}\n' http://localhost:8091
HTTP status: 200

==================== docker ps ====================
$ docker ps --filter name=multistage-app
CONTAINER ID   IMAGE                COMMAND     CREATED        STATUS                  PORTS                                         NAMES
7d0933bff7cc   multistage-app:1.0   "/server"   1 second ago   Up Less than a second   0.0.0.0:8091->8080/tcp, [::]:8091->8080/tcp   multistage-app

$ docker port multistage-app
8080/tcp -> 0.0.0.0:8091
8080/tcp -> [::]:8091

==================== there is no shell in a scratch image ====================
$ docker exec multistage-app /bin/sh -c 'echo hi'
OCI runtime exec failed: exec failed: unable to start container process: exec: "/bin/sh": stat /bin/sh: no such file or directory

$ docker inspect multistage-app --format 'ExposedPorts={{.Config.ExposedPorts}} PortBindings={{.HostConfig.PortBindings}}'
ExposedPorts=map[8080/tcp:{}] PortBindings=map[8080/tcp:[{invalid IP 8091}]]

==================== what is actually in the final image ====================
$ docker history multistage-app:1.0
IMAGE          CREATED         CREATED BY                            SIZE      COMMENT
cb1bc3e2e23c   3 seconds ago   ENTRYPOINT ["/server"]                0B        buildkit.dockerfile.v0
<missing>      3 seconds ago   EXPOSE [8080/tcp]                     0B        buildkit.dockerfile.v0
<missing>      3 seconds ago   COPY /out/server /server # buildkit   4.6MB     buildkit.dockerfile.v0

$ docker image inspect multistage-app:1.0 --format 'Layers: {{len .RootFS.Layers}}'
Layers: 1
```

![Multi-stage app in the browser](screenshots/multistage-app.png)

The page shows the required text, Hello World from Docker multi-stage build.

### About port 8080

The task asks to confirm the app runs on 8080. Host 8080 was already occupied on my laptop, so
I published to host 8091. Inside the container it's still 8080, and the output says so four
times over: `docker logs` prints `listening on :8080`, `docker ps` shows
`0.0.0.0:8091->8080/tcp`, `docker port` maps `8080/tcp -> 0.0.0.0:8091`, and `docker inspect`
reports `ExposedPorts=map[8080/tcp:{}]`. On a machine with 8080 free the only change is
`-p 8080:8080`.

### The size difference

436 MB single-stage against 6.53 MB multi-stage, for the same app behaving the same way. About
67 times smaller. `docker history` explains it: the final image is one 4.6 MB layer holding
just the binary, and `docker image inspect` confirms a single layer.

The failed `docker exec` is the part I liked. There's no `/bin/sh` to run because `scratch`
really does contain nothing. That's also why it's a good security story: no shell, no package
manager, no OS libraries, so there's very little attack surface and almost nothing for a CVE
scanner to find.

---

## Task 2: documentation

**Name:** Kartavya Panchal
**Roll No.:** 24BCS10343

Application running successfully: the screenshot above, plus the `curl` output showing
`<h1>Hello World from Docker multi-stage build</h1>` and `HTTP status: 200`.

`docker ps` with the container on port 8080: in the session above, showing
`0.0.0.0:8091->8080/tcp`, with `docker port` and `docker inspect` backing up that the container
port is 8080.

---

## Task 3: deploying three application types

Node.js, Python and Java, three images, three containers, all up at once. Source for these is
in [`../05-docker-fundamentals/`](../05-docker-fundamentals/).

```console
$ docker ps --filter name=hello-node --filter name=hello-python --filter name=hello-java --format 'table {{.Names}}\t{{.Image}}\t{{.Status}}\t{{.Ports}}'
NAMES          IMAGE              STATUS          PORTS
hello-java     hello-java:1.0     Up 35 minutes   0.0.0.0:8090->8080/tcp, [::]:8090->8080/tcp
hello-python   hello-python:1.0   Up 35 minutes   0.0.0.0:5001->5000/tcp, [::]:5001->5000/tcp
hello-node     hello-nodejs:1.0   Up 35 minutes   0.0.0.0:3100->3000/tcp, [::]:3100->3000/tcp

$ docker logs hello-node --tail 2
Node.js app listening on port 3000

$ curl -s http://localhost:3100
<h1>Hello World from Node.js</h1><p>Served from a Docker container.</p>

$ docker logs hello-python --tail 3
192.168.65.1 - - [03/Sep/2026 15:58:24] "GET / HTTP/1.1" 200 -
192.168.65.1 - - [03/Sep/2026 15:58:24] "GET / HTTP/1.1" 200 -
192.168.65.1 - - [03/Sep/2026 16:28:06] "GET / HTTP/1.1" 200 -

$ curl -s http://localhost:5001
<h1>Hello World from Python (Flask)</h1><p>Served from a Docker container.</p>

$ docker logs hello-java --tail 2
Java app listening on port 8080

$ curl -s http://localhost:8090
<h1>Hello World from Java</h1><p>Served from a Docker container.</p>

$ docker images --format 'table {{.Repository}}\t{{.Tag}}\t{{.Size}}' | grep -E 'hello-nodejs|hello-python|hello-java'
hello-java      1.0    744MB
hello-python    1.0    234MB
hello-nodejs    1.0    194MB

$ docker stats --no-stream --format 'table {{.Name}}\t{{.CPUPerc}}\t{{.MemUsage}}' hello-node hello-python hello-java
NAME           CPU %     MEM USAGE / LIMIT
hello-node     0.00%     8.52MiB / 7.748GiB
hello-python   0.02%     30.4MiB / 7.748GiB
hello-java     0.12%     63.76MiB / 7.748GiB
```

Running all three next to each other made the cost of each runtime obvious. Image size goes
Node 194 MB, Python 234 MB, Java 744 MB for a full JDK, against 6.53 MB for the Go multi-stage
image above. Idle memory lines up the same way, roughly 8.5 MB, 30 MB and 64 MB, since the JVM
reserves its heap up front.

Java is the obvious candidate for the same multi-stage treatment: build with
`eclipse-temurin:21-jdk`, then copy the compiled classes into `eclipse-temurin:21-jre`, or a
`jlink` runtime, and most of that 744 MB disappears.

Small thing I noticed: the Flask logs show the actual GET requests my `curl` commands made.
`docker logs` really is just the container's stdout and stderr, nothing more.

## Cleanup

```bash
docker rm -f multistage-app
docker rmi multistage-app:1.0 singlestage-app:1.0
```
