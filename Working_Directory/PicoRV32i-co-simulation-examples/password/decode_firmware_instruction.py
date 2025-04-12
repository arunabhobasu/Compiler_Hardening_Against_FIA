import sys
import subprocess

def decode_instruction(hex_path, mem_addr_hex):
    mem_addr = int(mem_addr_hex, 16)
    index = mem_addr >> 2

    # Read firmware.hex
    with open(hex_path, 'r') as f:
        lines = f.read().strip().splitlines()

    if index >= len(lines):
        print(f"[!] Address 0x{mem_addr:08X} is out of range. Max index: {len(lines)-1}")
        return

    instr_hex = lines[index].strip()
    print(f"[+] mem_addr = 0x{mem_addr:08X} → Line {index}, Instruction = {instr_hex}")

    # Write to binary (little-endian)
    bin_path = "temp_instr.bin"
    with open(bin_path, "wb") as bf:
        bf.write(bytes.fromhex(instr_hex)[::-1])

    # Disassemble
    result = subprocess.run([
        "riscv32-unknown-elf-objdump", "-D", "-b", "binary", "-m", "riscv", bin_path
    ], capture_output=True, text=True)

    if result.returncode == 0:
        print("[+] Disassembly:\n")
        print(result.stdout)
    else:
        print("[!] Error running objdump:\n", result.stderr)

if __name__ == "__main__":
    if len(sys.argv) != 3:
        print("Usage: python decode_firmware_instruction.py firmware32.hex 0xADDR")
    else:
        decode_instruction(sys.argv[1], sys.argv[2])
