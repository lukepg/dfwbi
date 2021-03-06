# This is the makefile used to build the dlib C++ library's regression test suite
# on Debian Linux using the gcc compiler.

# this is the name of the output executable
TARGET = svm_ex optimization_ex testLs

# these are the compile time flags passed to gcc
CFLAGS = -ggdb  -DDEBUG -DDLIB_NO_GUI_SUPPORT  -I /usr/local/include  -Wall

# These are the link time flags passed to gcc
LFLAGS = -L-/usr/local/lib -ldlib -lpthread   -lnsl 

# The name of the compiler.  If you only have one version of
# gcc installed then you probably want to change this to just g++ 
CC = nice g++

####################################################
####################################################
#  Here we list all the cpp files we want to compile

SRC = svm_ex.cpp
SRC1 = optimization_ex.cpp
SRC2 = testLs.cpp
####################################################

TMP = $(SRC:.cpp=.o)
OBJ = $(TMP:.c=.o)
TMP1 = $(SRC1:.cpp=.o)
OBJ1 = $(TMP1:.c=.o)
TMP2 = $(SRC2:.cpp=.o)
OBJ2 = $(TMP2:.c=.o)

all:$(TARGET)


svm_ex: $(OBJ) 
	@echo Linking $@
	$(CC) $(LFLAGS) $(OBJ) -o $@
	@echo Build Complete
optimization_ex: $(OBJ1) 
	@echo Linking $@
	$(CC) $(LFLAGS) $(OBJ1) -o $@
	@echo Build Complete

testLs: $(OBJ2) 
	@echo Linking $@
	$(CC) $(LFLAGS) $(OBJ2) -o $@
	@echo Build Complete

.cpp.o: $<
	@echo Compiling $<
	@$(CC) -c $(CFLAGS) $< -o $@

clean:
	@rm -f $(OBJ) $(TARGET)
	@echo All object files and binaries removed

dep: 
	@echo Running makedepend
	@makedepend -- $(CFLAGS) -- $(SRC) 2> /dev/null 
	@echo Completed makedepend

###############################################################################
##########  Stuff from makedepend                                         #####
##########  type make dep at the command line to rebuild the dependencies #####
##########  Also, DON'T edit the contents of this file beyond this line.  #####
###############################################################################

