
docker ps --format="{{.Names}}" | grep -q "^$1$" || docker ps -q | grep -q "^$1$"