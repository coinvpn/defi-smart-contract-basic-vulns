# DeFi Smart Contract Basic Vulnerabilities

This repository demonstrates **basic Ethereum / EVM smart contract vulnerabilities** for educational, testing, or research purposes.

⚠️ **Warning:** All contracts are intentionally vulnerable. **Do NOT deploy these on mainnet or with real funds.**

---

## 📦 Project Contents

Current Solidity contracts in this repository include:

| File | Description |
|------|-------------|
| `AttackReentrance.sol` | Reentrancy attack example |
| `AttackDelegation.sol` | Delegatecall vulnerability example |
| `AttackDelegation2.sol` | More advanced delegatecall example |
| `AttackGate.sol` | Logic gate / access control error example |
| `AttackGreeter.sol` | Basic logic flaw example |
| `Delegation.sol` | Vulnerable delegation contract |
| `DevDelegation.sol` | Development version of delegation contract |
| `test.sol` | Test / miscellaneous example code |

These examples cover **common DeFi smart contract vulnerability types**, such as reentrancy, delegatecall errors, and access control issues, allowing observation of how attacks exploit them.

---

## 🧠 What are Smart Contract Vulnerabilities?

Smart contracts are self-executing programs on the blockchain. Because of their **immutability**, **transparent code**, and handling of **financial assets**, they are often targets for attacks. Common vulnerabilities include:

- **Reentrancy** – External calls before state updates allow repeated withdrawals.  
- **Unsafe delegatecall** – Malicious code can take over the contract.  
- **Improper access control** – Critical functions without proper restrictions.  
- **Arithmetic errors (Overflow / Underflow)** – Can occur in older Solidity versions or without safe math.

---

## 🚀 How to Use

1. Clone the repository:  
   ```bash
   git clone https://github.com/coinvpn/defi-smart-contract-basic-vulns.git
   cd defi-smart-contract-basic-vulns
