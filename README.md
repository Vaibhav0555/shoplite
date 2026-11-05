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
