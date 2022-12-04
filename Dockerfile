FROM alpine
RUN apk add --update python3 py-pip
RUN pip install Flask
COPY . /app
WORKDIR /app
ENTRYPOINT [ "python3" ]
CMD [ "app.py" ]