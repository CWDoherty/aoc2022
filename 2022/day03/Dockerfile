FROM haskell:latest

ADD main.hs .
ADD input.txt .

RUN cabal update
RUN cabal install --lib split

CMD ["runhaskell", "main.hs"]
