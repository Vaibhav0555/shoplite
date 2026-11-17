# ShopLite operations (Project 3)

## Start / stop
- Start both containers: `docker start shoplite-db shoplite-api`
- Stop both containers: `docker stop shoplite-api shoplite-db`

## Health and logs
- Is the API alive?: `curl http://localhost:3000/health`
- Last 20 log lines of the API, live: `docker logs -f --tail 20 shoplite-api`
- How many times has the API restarted?: `docker inspect shoplite-api --format '{{.RestartCount}}'`

## Network
- API container's IP: `docker inspect shoplite-api --format '{{range .NetworkSettings.Networks}}{{.IPAddress}}{{end}}'`
- Can the API reach the database?:
  `docker exec shoplite-api nc -zv $(docker inspect shoplite-db --format '{{range .NetworkSettings.Networks}}{{.IPAddress}}{{end}}') 5432`
- Note: IPs change with start order (seen: api .2→.3, db .3→.2). Use names on a user-defined network instead (Module 9).

## Resources
- CPU/memory use of both, once: `docker stats --no-stream shoplite-api shoplite-db`

## Clean up (careful!)
- Remove the API container: `docker rm -f shoplite-api`