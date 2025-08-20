#RISCV_TOOLS_PREFIX = /opt/riscv32ic/bin/riscv32-unknown-elf-
RISCV_TOOLS_PREFIX = /opt/riscv32i/bin/riscv32-unknown-elf-
CXX = $(RISCV_TOOLS_PREFIX)g++
CC = $(RISCV_TOOLS_PREFIX)gcc
AS = $(RISCV_TOOLS_PREFIX)gcc
#CXXFLAGS = -Wall -MD -Os -std=c++11 -Wextra -Wshadow -Wundef -Wpointer-arith -Wcast-qual -Wcast-align -Wwrite-strings #-Werror
#CFLAGS  = -Wall -MD -Os -std=c++11 -Wextra -Wshadow -Wundef -Wpointer-arith -Wcast-qual -Wcast-align -Wwrite-strings #-Werror
CXXFLAGS = -MD -Os -Wall -std=c++11
CFLAGS = -MD -Os -Wall -std=c++11
LDFLAGS = -Wl,--gc-sections
LDLIBS =  # set -lstdc++ for C++ std linking lib

COMPRESSED_ISA = C
PICORV32_PATH = /home/arun/picorv32

# Source and object files
SRC = password.c # syscalls.cpp
ASM = $(SRC:.c=.s)
OBJ = $(SRC:.c=.o)

test: testbench.vvp firmware32.hex
	vvp -N testbench.vvp
 
testbench.vvp: testbench.v $(PICORV32_PATH)/picorv32.v
	iverilog -o testbench.vvp testbench.v $(PICORV32_PATH)/picorv32.v
	chmod -x testbench.vvp

firmware32.hex: firmware.elf start.elf hex8tohex32.py
	$(RISCV_TOOLS_PREFIX)objcopy -O verilog start.elf start.tmp
	$(RISCV_TOOLS_PREFIX)objcopy -O verilog firmware.elf firmware.tmp
	cat start.tmp firmware.tmp > firmware.hex
	python3 hex8tohex32.py firmware.hex > firmware32.hex
	rm -f start.tmp firmware.tmp

# Link: object files -> executable
firmware.elf: $(OBJ) syscalls.o
	$(CC) $(LDFLAGS) -o $@ $^ -T $(PICORV32_PATH)/firmware/riscv.ld $(LDLIBS)
	chmod -x firmware.elf

# The following 3 make targets are optional because of being implictly done by the target above

# Assemble: assembly -> object files
%.o: %.s
	$(CC) $(CXXFLAGS) -c $< -o $@

# Compile: C -> assembly
%.s: %.c
	$(CC) $(CFLAGS) -S $< -o $@

# Compile: C++ (syscalls.cpp) -> assembly 
%.s: %.cpp
	$(CC) $(CXXFLAGS) -S $< -o $@

# An alternative compilation to keep the assembly codes
assembly: $(SRC)
	$(CC) $(CFLAGS) -S $(SRC)
	cat $(ASM) > combined.s

start.elf: start.S start.ld
	$(CC) -nostdlib -o start.elf start.S -T start.ld $(LDLIBS)
	chmod -x start.elf

clean:
	rm -f *.s *.o *.d *.tmp start.elf
	rm -f firmware.elf firmware.hex firmware32.hex
	rm -f testbench.vvp

-include *.d
.PHONY: test clean
