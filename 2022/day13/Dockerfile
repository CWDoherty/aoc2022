FROM nimlang/nim:latest

ADD . .
RUN nim compile -d:release main.nim

CMD ["./main"]
