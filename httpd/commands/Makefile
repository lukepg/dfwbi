INCLUDE=-I./libscws -I../log -I/usr/local/include -I ../factory
LIB=-ldl -L./libscws -lscws -L../ -L/usr/local/lib -L../factory -lboost_iostreams -lboost_serialization -lfactory
CC=g++
LIBTAR=status.so
LIBOBJ=status.o
LIBTAR1=Segment.so
LIBOBJ1=Segment.o
DEST=$(LIBTAR) $(LIBTAR1) 
CFLAGS=-g -c -fPIC -D_XLNX64
LFLAGS=-shared -Wl,-soname,$(LIBTAR).1
.cpp.o:
	@echo Compiling cc program $< ......
	@echo c to o
	$(CC) $(CFLAGS) $(INCLUDE) $<
all:$(DEST)

$(LIBTAR):$(LIBOBJ)
	$(CC) $(LFLAGS) -o $(LIBTAR) $(LIBOBJ) $(LIB)
$(LIBTAR1):$(LIBOBJ1)
	$(CC) $(LFLAGS) -o $(LIBTAR1) $(LIBOBJ1) $(LIB)
clean: 
	rm -rf *.o *.so $(DEST) *~
