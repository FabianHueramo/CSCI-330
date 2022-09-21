CXX=g++
CXXFLAGS=-g -Wall

dog : dog.o dogfunc.o
	$(CXX) $(CXXFLAGS) -o dog dog.o dogfunc.o

dog.o : dog.cc
	$(CXX) $(CXXFLAGS) -c dog.cc

dogfunc.o : dogfunc.cc
	$(CXX) $(CXXFLAGS) -c dogfunc.cc

clean:
	rm *
