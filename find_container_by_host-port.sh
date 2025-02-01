#!/bin/bash

# Colors
GREEN="\e[32m"
RED="\e[31m"
CYAN="\e[36m"
RESET="\e[0m"

ifconfig

# Display Example Input for User Clarity
echo -e "${CYAN}Example Input:${RESET}"
echo -e "Enter IP range (e.g., 192.168.1): 172.17.0"
echo -e "Enter the last octet range (e.g., 1-254): 1-16\n"

# Get user input for IP discovery
echo -ne "${CYAN}Enter IP range (e.g., 192.168.1): ${RESET}"
read ip_range
echo -ne "${CYAN}Enter the last octet range (e.g., 1-254): ${RESET}"
read last_octet_range

# Convert last octet range into start and end
IFS='-' read -r start_octet end_octet <<< "$last_octet_range"

echo -e "\n${CYAN}Scanning live hosts in $ip_range.X...${RESET}"
live_hosts=()
for i in $(seq "$start_octet" "$end_octet"); do
    ip="$ip_range.$i"
    if ping -c 1 -W 1 "$ip" &>/dev/null; then
        echo -e "${GREEN}Host Up: $ip${RESET}"
        live_hosts+=("$ip")
    fi
done

# If no hosts are found, exit
if [ ${#live_hosts[@]} -eq 0 ]; then
    echo -e "${RED}No live hosts found. Exiting.${RESET}"
    exit 1
fi

# Ask for port scan details only after discovering live hosts
echo -e "\n${CYAN}Enter target IP for port scan (from the discovered hosts): ${RESET}"
read target_ip
echo -ne "${CYAN}Enter port range (e.g., 1-65535): ${RESET}"
read port_range

# Scan ports on the selected IP
echo -e "\n${CYAN}Scanning open ports on $target_ip...${RESET}"
IFS='-' read -r start_port end_port <<< "$port_range"
for port in $(seq "$start_port" "$end_port"); do
    nc -z -w1 "$target_ip" "$port" &>/dev/null && echo -e "${GREEN}Open Port: $target_ip:$port${RESET}"
done
