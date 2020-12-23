FROM python:3

RUN mkdir -p /macc2

ADD * /macc2/

WORKDIR /macc2

EXPOSE 443

RUN pip3 install aiohttp

CMD ["python3", "MacC2_server.py"]
