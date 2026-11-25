# 🔐 CipherMIPS

**A menu-driven Caesar and XOR cipher toolkit written in MIPS Assembly.**

CipherMIPS demonstrates low-level string processing, ASCII manipulation, byte-level memory access, bitwise operations, procedures, branching, and MIPS syscalls.

## ✨ Features
- Caesar Cipher encryption and decryption
- Uppercase and lowercase support with alphabet wraparound
- XOR Cipher transformation and reversibility using the same key
- Menu-driven interface
- Message/key input and validation
- XOR byte-value output for non-printable encrypted data

## 🧠 How It Works
```text
                    CipherMIPS
                        |
                        v
                   Main Menu
                        |
          +-------------+-------------+
          |                           |
          v                           v
    Caesar Cipher                 XOR Cipher
    Encrypt/Decrypt              Transform bytes
          |                           |
          v                           v
     ASCII shifting                Bitwise XOR
          |                           |
          +-------------+-------------+
                        |
                        v
                      Output
```

### Caesar Cipher
The Caesar cipher shifts each alphabetic character by a user-provided key.

```text
Message: hello
Key: 3
Encrypted: khoor
Decrypted: hello
```

Wraparound is supported, so with key `3`, `x -> a`, `y -> b`, and `z -> c`.

### XOR Cipher
Each input byte is XORed with the key:
```text
encrypted_byte = original_byte XOR key
encrypted_byte XOR key = original_byte
```
Because XOR can produce non-printable characters, CipherMIPS displays the transformed result as byte values and demonstrates recovery of the original message.

## 📁 Project Files
```text
CipherMIPS/
├── main.asm
├── caesar_cipher.asm
├── xorCipher.asm
├── CONTRIBUTIONS.md
└── README.md
```

### `main.asm`
Controls the menu, reads the message and key, validates input, calls the selected cipher procedure, displays results, and integrates both cipher modules.

### `caesar_cipher.asm`
Contains `encrypt` and `decrypt`. It processes the string byte-by-byte, identifies uppercase/lowercase ASCII characters, shifts by the key, handles wraparound, and modifies the message in place.

### `xorCipher.asm`
Processes each input byte with the XOR key and writes the transformed bytes into a separate output buffer.

## 🛠️ MIPS Concepts Used
- Registers and procedure arguments
- `lb`, `lbu`, and `sb`
- ASCII character ranges
- String traversal with pointers
- Loops and conditional branches
- `add`, `sub`, and `xor`
- `jal` and `jr $ra`
- MIPS input/output syscalls
- Null-terminated strings
- Input/output buffers
- Modular assembly files using `.include`

## ▶️ Running the Project
Designed for **MARS**.

1. Keep `main.asm`, `caesar_cipher.asm`, and `xorCipher.asm` in the same directory.
2. Open **`main.asm`** in MARS.
3. Assemble `main.asm`; it includes the two cipher files automatically.
4. Run the program and select an option.

```text
========== CipherMIPS ==========
1. Caesar Cipher - Encrypt
2. Caesar Cipher - Decrypt
3. XOR Cipher
4. Exit
Select an option:
```

Caesar keys: **1-25**  
XOR keys: **1-255**

## 👥 Team
| Team Member | Contribution |
|---|---|
| **Arnav Nallani** | Menu, user input, validation, program flow, and integration |
| **Amey Sirdeshpande** | Caesar Cipher encryption and decryption |
| **Ravneet Kaur** | XOR Cipher encryption and decryption |

See `CONTRIBUTIONS.md` for the detailed breakdown.

## 🎯 Project Purpose
CipherMIPS is an educational project demonstrating how string transformations can be implemented directly in assembly language.

The Caesar and XOR ciphers used here are simple learning examples and are **not intended for real-world cryptographic security**.

---
### CipherMIPS
**Encryption, one instruction at a time. 🔐**
