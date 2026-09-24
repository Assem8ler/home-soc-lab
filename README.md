# 🛡️ Home SOC Lab: Wazuh SIEM Deployment & Attack Detection

Welcome to my personal cybersecurity project! In this repository, I document the process of building a **Security Operations Center (SOC) home lab**. 

The goal of this project is to simulate a corporate environment where an endpoint is monitored by a SIEM (Security Information and Event Management) system, and then perform simulated attacks to analyze how those attacks are detected.

## 🎯 Project Objectives
- [x] Design the lab architecture (Attacker, Victim, SIEM Server).
- [x] Deploy Wazuh SIEM server using VirtualBox.
- [x] Install and configure Wazuh Agent on Windows 11.
- [x] Perform a simulated attack using Kali Linux (e.g., Port Scanning / Brute Force).
- [x] Analyze and interpret security alerts in the Wazuh Dashboard.
- [x] Document the findings.

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
## Detection Results

| Attack | Tool | Victim telemetry | Rule chain | Levels | MITRE ATT&CK |
|---|---|---|---|---|---|
| SYN port scan | `nmap -sS --top-ports 100` | WFP packet drop (Security Event ID **5152**) | **100001 → 100002** (custom, see `rules/local_rules.xml`) | 3 → **8** | **T1046** – Network Service Discovery |
| SMB password guessing | `netexec smb` | Logon failure (Security Event ID **4625**) | **18130 → 40111 → 18116** (built-in) | 5 → **10** → 9 | **T1110** – Brute Force, **T1531** – Account Access Removal |

**How the custom scan detection works:** rule `100001` matches every WFP block event (5152); frequency rule `100002` fires when 10+ such events arrive within 120 seconds and raises a level-8 alert "Possible port scan detected". The brute-force chain is built-in: per-failure alert `18130`, frequency alert `40111` ("Multiple authentication failures"), and account lockout consequence `18116`.

### Alert evidence
- `screenshots/02-scan-probes-100001.png` — raw WFP block events during the scan
- `screenshots/03-scan-alert-100002.png` — custom level-8 scan verdict
- `screenshots/04-high-alert-40111.png` — brute-force high alert (level 10)
- `screenshots/05-alert-card-json.png` — full alert JSON: source IP, target account, MITRE tag
- `screenshots/06-mitre-events.png`, `07-mitre-framework.png` — MITRE mapping (T1046 / T1110)

## Lessons Learned

1. **Windows audit policy is volatile.** Effective `auditpol` settings reset on VM reboot; re-apply categories ("Object Access", "Logon/Logoff") after every restart.
2. **Real-time subscription vs journal polling.** The `eventchannel` real-time subscription silently missed WFP events (5152/5156) in this environment; switching the Security log collection to `log_format=eventlog` (journal polling) restored full delivery.
3. **Debug pipeline with X-ray tools.** Temporary `<logall>yes</logall>` (incoming event archive) plus `wazuh-logtest` phase output (pre-decoding → decoding → filtering) pinpointed every break in the detection chain.
4. **Know your decoder.** Classic Windows events (`WinEvtLog`) chain from base rule **18105**, and the event number lives in the `id` field of the `windows` decoder.
5. **Dashboards speak multiple dialects.** OpenSearch search bar switches between KQL, DQL and Lucene — the same filter looks different in each (`rule.level:>9` vs `rule.level > 9` vs `rule.level:[10 TO 15]`).
6. **The firewall is part of the detection.** netexec "NETBIOS connection timed out" lines are WFP drops on the victim — the same drops that feed rule 100001. Defense and telemetry are two sides of one event.

## Project Status

✅ Completed: lab deployment, Windows agent, attack simulation (scan + brute force), custom and built-in detection tuning, MITRE mapping, evidence collection.
