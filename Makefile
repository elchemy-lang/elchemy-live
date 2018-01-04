setup:
	python3 -m venv ./env && . env/bin/activate && pip3 install -r requirements.txt
	yarn

docker:
	./dotenv yarn build:production
	docker build . -t elchemy:dev

start-server:
	./dotenv flask run

start-client:
	./dotenv yarn watch

build-compiler:
	./dotenv npm run-script build:make
