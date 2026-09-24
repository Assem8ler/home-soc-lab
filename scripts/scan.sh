#!/bin/bash
# Recon: SYN scan of the victim (generates WFP 5152 drops on victim)
sudo nmap -sS -T4 --top-ports 100 192.168.56.102
