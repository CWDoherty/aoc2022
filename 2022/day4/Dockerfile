FROM gcc:latest

ADD input.txt .
ADD main.cpp .

RUN g++ -std=c++11 -o main main.cpp

CMD ["./main"]
