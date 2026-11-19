# 🔐 CipherMIPS

### A lightweight encryption & decryption toolkit built entirely in MIPS Assembly

CipherMIPS is a command-line encryption and decryption program written in **MIPS Assembly**. It explores low-level string processing, ASCII manipulation, bitwise operations, loops, branches, and procedures.

## 🚀 Features

### 🔤 Caesar Cipher
- Encryption and decryption
- Uppercase and lowercase support
- Alphabet wraparound
- Preserves non-alphabetic characters

```text
Message: HELLO WORLD
Key: 3
Encrypted: KHOOR ZRUOG
```

### ⚡ XOR Cipher
Processes each character using bitwise XOR with a user-provided key.

```text
EncryptedByte = OriginalByte XOR Key
OriginalByte  = EncryptedByte XOR Key
```

## 🧠 How It Works

```text
                    CipherMIPS
                        |
                        v
                   Main Menu
                        |
              +---------+---------+
              |                   |
              v                   v
        Caesar Cipher         XOR Cipher
              |                   |
              v                   v
        ASCII shifting        Bitwise XOR
              |                   |
              +---------+---------+
                        v
              Encrypted / Decrypted
                      Output
```

## 🛠️ MIPS Concepts Used

- String traversal using memory addresses
- Byte-level access with `lb` and `sb`
- ASCII character manipulation
- Bitwise XOR
- Registers and argument passing
- Loops and conditional branches
- Procedures using `jal` / `jr $ra`
- MIPS syscalls
- Character buffers
- Modular program design

## 📁 Project Structure

```text
CipherMIPS/
├── caesar_cipher.asm
├── xorCipher.asm
├── main.asm
└── README.md
```

> `main.asm` and final integration are currently under development.

## 🌿 Development Branches

```text
main
├── menu-input-integration
├── caesar-encryption-decryption
└── xor-encryption-decryption
```

## 📊 Development Status

| Component | Status |
|---|---|
| Caesar Encryption | ✅ Complete |
| Caesar Decryption | ✅ Complete |
| XOR Encryption / Decryption | ✅ Complete |
| Menu System | 🚧 In Progress |
| User Input / Key Handling | 🚧 In Progress |
| Module Integration | 🚧 In Progress |
| Final Testing | ⏳ Pending |

## 👥 Team Responsibilities

### Person 1 — Menu & Integration
Menu system, user input, key handling, program flow, and module integration.

**Status:** 🚧 In Progress

### Person 2 — Caesar Cipher
Caesar encryption/decryption, uppercase/lowercase handling, and alphabet wraparound.

**Status:** ✅ Complete

### Person 3 — XOR Cipher
XOR transformation, byte-by-byte processing, and output buffer handling.

**Status:** ✅ Complete

## 🧪 Planned Final Interface

```text
=================================
          CipherMIPS
=================================

1. Caesar Cipher - Encrypt
2. Caesar Cipher - Decrypt
3. XOR Cipher - Encrypt
4. XOR Cipher - Decrypt
5. Exit

Select an option: 1

Enter message:
HELLO WORLD

Enter key:
3

Encrypted message:
KHOOR ZRUOG
```

## 🎯 Project Goal

CipherMIPS is an educational project. Caesar and basic XOR ciphers are intentionally simple and should **not** be used for real security.

The goal is to demonstrate how encryption concepts can be implemented directly at the assembly level, where string operations become operations on individual bytes in memory.

## 🔜 Next Steps

- [x] Implement Caesar encryption
- [x] Implement Caesar decryption
- [x] Implement XOR cipher
- [ ] Complete main menu
- [ ] Connect encryption modules
- [ ] Add user input and key handling
- [ ] Test edge cases
- [ ] Complete final integration
- [ ] Prepare final demonstration

## 💻 Built With

**MIPS Assembly**, designed to run using a MIPS simulator such as **MARS**.

---

### CipherMIPS

**Encryption, one instruction at a time. 🔐**
