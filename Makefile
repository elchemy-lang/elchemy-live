setup:
	python3 -m venv ./env && . env/bin/activate && pip install -r requirements.txt
	yarn

start-server:
	dotenv flask run

start-client:
	dotenv yarn watch