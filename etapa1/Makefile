# Bianca Pelegrini - 279598

CXX = g++
CXXFLAGS = -std=c++11 -Wall -c 

target: etapa1

etapa1: lex.yy.o main.o
	$(CXX) -o etapa1 lex.yy.o main.o

main.o: main.cpp
	$(CXX) $(CXXFLAGS) main.cpp

lex.yy.o: lex.yy.cpp
	$(CXX) $(CXXFLAGS) -lfl lex.yy.cpp

lex.yy.cpp: scanner.l
	flex -o lex.yy.cpp scanner.l

clean:
	rm etapa1 *.yy.* *.o