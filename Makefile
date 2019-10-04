# all source files (like .c or .h) should be in SRCDIR
# all object files will be in OBJDIR
# executable will be in BINDIR

# project name (generate executable with this name)
TARGET   = ProjectName

CC       = gcc
# c compiling flags here
CFLAGS   = -Wall -g

LINKER   = gcc
# linking flags here
LFLAGS   = -Wall

# change these to proper directories where each file should be
SRCDIR   = src
OBJDIR   = obj
BINDIR   = bin

# resursive wildcard function, thanks to: https://stackoverflow.com/a/12959764
rwildcard=$(wildcard $1/$2) $(foreach d,$(wildcard $1/*),$(call rwildcard,$d/,$2))

CSOURCES  := $(call rwildcard,$(SRCDIR),*.c)
COBJECTS  := $(CSOURCES:$(SRCDIR)/%.c=$(OBJDIR)/%.o)
rm       = rm -rf

# link all objects and build executable
$(BINDIR)/$(TARGET): $(COBJECTS)
	@mkdir -p $(@D)
	@$(LINKER) $(COBJECTS) $(LFLAGS) -o $@
	@echo "Linking complete!"

# compile each source into object
$(COBJECTS): $(OBJDIR)/%.o : $(SRCDIR)/%.c
	@mkdir -p $(@D)
	@$(CC) $(CFLAGS) -c $< -o $@
	@echo "Compiled "$<" successfully!"

.PHONY: clean
clean:
	@$(rm) $(OBJDIR)
	@$(rm) $(BINDIR)
	@echo "Cleanup complete!"