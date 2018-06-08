
bPush:
	make build && make push
build:
	docker build -t luluisco/mlds-notebook .
push:
	docker push luluisco/mlds-notebook