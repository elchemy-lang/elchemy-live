build-image:
	docker build -t ellie:fresh .
docker-deploy:
	docker stop elchemy-instance ; docker rm elchemy-instance || true
	docker rmi ellie:fresh ; make build-image
	docker run -d -e PORT=8000 -p 8000:8000 --name elchemy-live --env-file .env.local --name elchemy-instance ellie:fresh
