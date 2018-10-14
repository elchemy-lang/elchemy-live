build-image:
	docker build -t ellie:fresh .
docker-deploy:
	git pull
	docker stop elchemy-instance ; docker rm elchemy-instance ; true
	docker rmi ellie:fresh
	make build-image
	docker run -e PORT=8000 -p 8000:8000 --name dupa --env-file .env.local --name elchemy-instance ellie:fresh
