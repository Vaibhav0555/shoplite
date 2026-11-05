const http = require("http");
const fs = require("fs");

const PORT = 3000;

const server = http.createServer((req, res) => {
  if (req.url === "/health") {
    res.end("ok");
  } else if (req.url === "/products") {
    const products = fs.readFileSync("products.json", "utf8");
    res.setHeader("Content-Type", "application/json");
    res.end(products);
  } else {
    res.statusCode = 404;
    res.end("not found");
  }
});

server.listen(PORT, () => {
  console.log("ShopLite running on port " + PORT);
});
