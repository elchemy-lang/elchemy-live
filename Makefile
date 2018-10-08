build-image:
	docker build -t ellie:fresh .
docker-deploy:
	docker stop elchemy-instance || true && docker rm elchemy-instance || true
	(docker rmi ellie:fresh || true) &&  make build-image
	docker run -d -e PORT=8000 -p 8000:8000 --name dupa --env-file .env.local --name elchemy-instance ellie:fresh
