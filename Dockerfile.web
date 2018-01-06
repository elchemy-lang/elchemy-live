FROM python:3

ADD . /app
WORKDIR "/app"
RUN pip3 install -r requirements.txt

CMD env && (yarn watch &) && flask run --host=0.0.0.0 --port=$PORT

EXPOSE 5000
