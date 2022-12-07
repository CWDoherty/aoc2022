FROM racket/racket:latest

ADD main.rkt .
RUN raco pkg install --auto advent-of-code
CMD ["racket", "main.rkt"]
