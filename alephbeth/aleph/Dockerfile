FROM python:3.7-alpine
ADD . /usr/src/app
WORKDIR /usr/src/app
RUN pip install -r requirements.txt
EXPOSE 80
CMD ["python", "api.py"]
