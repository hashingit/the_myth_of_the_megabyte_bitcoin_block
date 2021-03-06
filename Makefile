CC := g++
CFLAGS := -std=c++11 -O2 -Wall -pthread
LDFLAGS := -std=c++11 -pthread
RM := rm

#
# Define our target app.
#
APP := mb_block

#
# Define the source files for our build.
#
MB_BLOCK_SRCS := mb_block.cc

#
# Create a list of object files from source files.
#
MB_BLOCK_OBJS := $(patsubst %.cc,%.o,$(filter %.cc,$(MB_BLOCK_SRCS)))


%.o : %.cc
	$(CC) $(CFLAGS) -MD -c $< -o $@

.PHONY: all

all: $(APP)

mb_block: $(MB_BLOCK_OBJS)
	$(CC) $(LDFLAGS) -o $@ $(MB_BLOCK_OBJS)

-include $(MB_BLOCK_OBJS:.o=.d) 

.PHONY: clean

clean:
	$(RM) -f $(APP) *.o $(patsubst %,%/*.o,$(SUBDIRS))
	$(RM) -f $(APP) *.d $(patsubst %,%/*.d,$(SUBDIRS))

.PHONY: realclean

realclean: clean
	$(RM) -f *~ $(patsubst %,%/*~,$(SUBDIRS))

