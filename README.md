# 🛡️ Home SOC Lab: Wazuh SIEM Deployment & Attack Detection

Welcome to my personal cybersecurity project! In this repository, I document the process of building a **Security Operations Center (SOC) home lab**. 

The goal of this project is to simulate a corporate environment where an endpoint is monitored by a SIEM (Security Information and Event Management) system, and then perform simulated attacks to analyze how those attacks are detected.

## 🎯 Project Objectives
- [x] Design the lab architecture (Attacker, Victim, SIEM Server).
- [ ] Deploy Wazuh SIEM server using VirtualBox.
- [ ] Install and configure Wazuh Agent on Windows 11.
- [ ] Perform a simulated attack using Kali Linux (e.g., Port Scanning / Brute Force).
- [ ] Analyze and interpret security alerts in the Wazuh Dashboard.
- [ ] Document the findings.

## 🏗️ Lab Architecture

| Role | Operating System | Purpose |
|------|------------------|---------|
| 🕵️ **SIEM Server** | Wazuh (Ubuntu-based) | Collects logs, analyzes events, generates alerts. |
| 💻 **Victim** | Windows 11 | Sends security logs to the server via Wazuh Agent. |
| 🎩 **Attacker** | Kali Linux | Simulates offensive actions against the Victim. |

## 🛠️ Tools & Technologies
- VirtualBox (Hypervisor)
- Wazuh (SIEM / XDR)
- Kali Linux (Offensive Security)
- Windows 11 (Endpoint)

> ⚠️ **Disclaimer:** All attacks are performed in an isolated, closed VirtualBox network environment for educational purposes only.

---
*Project Status: 🚧 In Progress...*
