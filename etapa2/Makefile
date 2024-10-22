# Bianca M Pelegrini - 279598

CXX = g++
CXXFLAGS = -std=c++11 -Wall -c 

target: etapa2

etapa2: parser.tab.o lex.yy.o main.o
	$(CXX) -o etapa2 lex.yy.o main.o parser.tab.o

parser.tab.o: parser.tab.c
	$(CXX) $(CXXFLAGS) parser.tab.c

lex.yy.o: lex.yy.cpp
	$(CXX) $(CXXFLAGS) lex.yy.cpp

lex.yy.cpp: scanner.l parser.tab.c
	flex -o lex.yy.cpp scanner.l

parser.tab.c: parser.y
	bison -d -v parser.y

main.o: main.cpp
	$(CXX) $(CXXFLAGS) main.cpp

clean:
	rm etapa2 *.yy.* *.o *.output *.tab.*
	