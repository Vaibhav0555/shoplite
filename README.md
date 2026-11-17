#ShopLite v0

A tiny shop API with two addresses: /health and /products.

## What this app needs to run (without Docker)
- Operating system: any OS with Node.js installed
- Runtime: Node.js (any recent version)
- Libraries: none (http and fs are built into Node.js)
- Port it uses: 3000

## Setup steps on a new machine
1. Install Node.js
2. Copy server.js and products.json into one folder
3. Run: node server.js

## What happened on my laptop
- I ran: node server.js
- Result: Command 'node' not found
- Why: Node.js is not installed on this laptop, so the app cannot run here.
  Docker will fix this later by shipping Node.js inside the container.


## Project 1: what isolates my database

Database: PostgreSQL 17 in a container (`postgres:17-alpine`), memory limit 256 MiB.

| Check | Inside the container | On the host |
|---|---|---|
| PID of postgres | 1 |20529 |
| Hostname |6a3afaa810d7 | admin1-HP-EliteBook-840-G6 |
| IP address | inet 172.17.0.2/16 brd 172.17.255.255 scope global eth0 | (laptop Wi-Fi IP) |
| OS files |NAME="Alpine Linux" | Ubuntu 24.04 |

- Namespaces used: PID, mnt, hostname, NET
- cgroup memory limit: 268435456 bytes (= 256 MiB)
- Parent process on the host: 20507 (runc is not running, because its work just to create container and get out then contained-shim maintain the container)
- In one line: a container is just a normal process running inside the container but using nam space and cgroup it feel like it is isolated

## Project 4: pinned and portable images

| Image | Pinned digest |
|---|---|
| node:22-alpine | node@sha256:1314fb30ec37592d5845e5a160d522c0e680972aa534549940b8d73bde88481a|
| postgres:17-alpine | postgres@sha256:d3244e8ce3f165ee3c93d9c4a4b1d0fe48b3a89e2287b717fdcbbde92d405065 |

- The API now runs from: `node@sha256:1314fb30ec37592d5845e5a160d522c0e680972aa534549940b8d73bde88481a` (the value of {{.Config.Image}})
- Why pin by digest: A tag can move to new content; a digest is calculated from the exact content, so every machine pulls the identical image.
- Offline transfer: `docker save node:22-alpine postgres:17-alpine | gzip > shoplite-images.tar.gz` → 166 MB
- Load on another machine: gunzip -c shoplite-images.tar.gz | docker load, the full command, so future-you can copy it
- What fills the images (from `docker image history`):RUN … wget … postgresql (downloads and builds PostgreSQL) — 295 MB