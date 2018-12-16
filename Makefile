

SRCS=main.cpp

TARGET_ROOT=test

CXXFLAGS+=-std=c++11
LDDFLAGS?=""
RUN=./

ifneq (,$(findstring em,$(CC)))
TARGET=$(TARGET_ROOT).html
LDDFLAGS+=--emrun
CXXFLAGS+=-s WASM=0
RUN=emrun ./
else
TARGET=$(TARGET_ROOT)
endif

OBJS=$(SRCS:.cpp=.o)

$(TARGET): $(OBJS) Makefile
	$(CXX) $(OBJS) -o $@

%.o: %.cpp
	$(CXX) $(CXXFLAGS) -c $^ -o $@

run: $(TARGET)
	$(RUN)$^

clean:
	rm -f $(TARGET)
	rm -f $(OBJS)
	rm -f *.html
	rm -f *.wasm
	rm -f *.js
