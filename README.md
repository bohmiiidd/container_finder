# container_finder
This Bash script is designed to discover container hosts on your network and then check open ports on selected containers using ping and nc (netcat)

### **How It Works**
1️⃣ **IP Range Discovery**  
   - The script first prompts for an **IP range** and **last octet range**.  
   - It uses `ping` to check which IPs are **active** (i.e., reachable).  
   
2️⃣ **Port Scanning**  
   - After discovering active IPs, the user can select a **target container** and provide a **port range**.  
   - The script then uses `nc (netcat)` to **scan** the specified ports on the target container.  

3️⃣ **Output**  
   - The script **prints out only the live IPs** and any **open ports** it finds.  

---

### **Example User Input**
```bash
Enter IP range (e.g., 192.168.1): 172.17.0
Enter the last octet range (e.g., 1-16): 1-10
Enter target IP for port scan (from discovered hosts): 172.17.0.3
Enter port range (e.g., 20-1000): 20-80
```

### **Example Output**
```bash
[+] Host Up: 172.17.0.2
[+] Host Up: 172.17.0.5
[+] Open Port: 172.17.0.3:22
[+] Open Port: 172.17.0.3:80
```

---
