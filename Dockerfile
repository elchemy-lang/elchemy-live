FROM python:3

RUN curl -sL https://deb.nodesource.com/setup_8.x | bash && apt-get install nodejs
RUN npm i -g elm yarn --unsafe-perm=true --allow-root

ADD . /app
WORKDIR "/app"
RUN pip3 install -r requirements.txt

CMD env && (yarn watch &) && flask run --host=0.0.0.0 --port=$PORT

EXPOSE 5000
