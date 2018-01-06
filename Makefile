setup:
	python3 -m venv ./env && . env/bin/activate && pip3 install -r requirements.txt
	yarn

docker-build:
	./dotenv yarn build:production
	docker build . -t elchemy:dev

docker-run:
	docker run --env-file .env --env-file .secretenv -p 5000:5000 -p 8000:8000 -e PORT=5000 -d --name elchemy elchemy:dev

docker-publish:
	docker tag elchemy:dev registry.heroku.com/elchemy-live/web
	docker push registry.heroku.com/elchemy-live/web

start-server:
	./dotenv flask run

start-client:
	./dotenv yarn watch

build-compiler:
	./dotenv npm run-script build:make
