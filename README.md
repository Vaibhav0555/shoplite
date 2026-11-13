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