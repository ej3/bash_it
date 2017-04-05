FROM bash:latest

COPY ./test.conf /etc/test.conf

CMD ["cat", "/etc/test.conf"]
