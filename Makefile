all:
	make setup
	make build-compiler
	yarn elm-css
	./dotenv yarn build:production

setup:
	python3 -m venv ./env && . env/bin/activate && pip3 install -r requirements.txt
	yarn
	cd client && elm-install && cd ../

docker-build:
	docker build . -t elchemy:dev

docker-run:
	docker run --env-file .env --env-file .secretenv -p 5000:5000 -p 8000:8000 -e PORT=5000 -d --name elchemy elchemy:dev

heroku-publish:
	heroku container:push web -a elchemy-live --recursive

start-server:
	./dotenv flask run

start-client:
	./dotenv yarn watch

build-compiler:
	./dotenv npm run-script build:make
