

SRCS=main.cpp

TARGET=test

CXXFLAGS+=-std=c++11

OBJS=$(SRCS:.cpp=.o)

$(TARGET): $(OBJS) Makefile
	$(CXX) $(OBJS) -o $@

%.o: %.cpp
	$(CXX) $(CXXFLAGS) -c $^ -o $@

run: $(TARGET)
	./$^

clean:
	rm -f $(TARGET)
	rm -f $(OBJS)
