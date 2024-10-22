# Bianca M Pelegrini - 279598

CXX = g++
CXXFLAGS = -std=c++11 -Wall -c 

target: etapa2

etapa2: parser.tab.o lex.yy.o main.o
	$(CXX) -o etapa2 lex.yy.o main.o parser.tab.o

parser.tab.o: parser.tab.cpp
	$(CXX) $(CXXFLAGS) parser.tab.cpp

lex.yy.o: lex.yy.cpp
	$(CXX) $(CXXFLAGS) lex.yy.cpp

lex.yy.cpp: scanner.l parser.tab.cpp
	flex -o lex.yy.cpp scanner.l

parser.tab.cpp: parser.y
	bison -d -v parser.y -o parser.tab.cpp

main.o: main.cpp
	$(CXX) $(CXXFLAGS) main.cpp

clean:
	rm etapa2 *.yy.* *.o *.output *.tab.*
	