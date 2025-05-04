
# Complete Beginner-Friendly Guide: Installing, Configuring, and Testing Application with OWASP ZAP on AWS EC2

## 1. Launch AWS EC2 Instance
- **Choose OS**: Ubuntu 22.04
- **Instance Type**: t2.medium (2 vCPU, 4 GB RAM)
- **Storage**: 10–20 GB

### Security Group Settings:
- Port 22 (SSH) - to connect
- Port 8080 (optional) - if you want to access ZAP remotely

Launch the instance and note the public IP.

- SSH (Port 22): To access the EC2 instance via SSH for management and configuring ZAP.

- ZAP GUI Port (e.g., 8080): If you want to access OWASP ZAP remotely (through a web browser).


Outbound Rules:
- Default Behavior (No Outbound Restrictions):
By default, AWS Security Groups allow all outbound traffic, meaning your EC2 instance can access external servers, the internet, and other resources without any restrictions.

- OWASP ZAP doesn’t require outbound traffic to test an application hosted on the same EC2 instance. The application and ZAP can communicate internally through the localhost (127.0.0.1) or internal IPs.

- Priority 100 > *

##  2. Connect to EC2 via SSH
On your laptop, connect to the instance:

```bash
ssh -i your-key.pem ubuntu@your-ec2-public-ip
```

##  3. Install Required Packages
Update system and install Java (ZAP needs Java):

```bash
sudo apt update
sudo apt install openjdk-17-jdk wget -y
java -version
```

(Java version 11 or higher is needed.)
    Java 17 Recomended

##  4. Download and Install OWASP ZAP

```bash
wget https://github.com/zaproxy/zaproxy/releases/download/v2.16.1/ZAP_2_16_1_unix.sh -O zap_installer.sh

chmod +x zap_installer.sh
./zap_installer.sh
```

## 5. Start OWASP ZAP in Daemon (Headless) Mode
Run ZAP in the background without GUI:

```bash
./zap.sh -daemon -port 8080 -host 0.0.0.0
```

Now ZAP is running and ready to accept commands.

## 6. What Happens Inside OWASP ZAP?
When you scan a website or app, OWASP ZAP automatically does these steps:

| Step            | What It Means                                                                 |
|-----------------|-------------------------------------------------------------------------------|
| **Spidering**    | Crawls your website to discover all pages and links                           |
| **Passive Scan** | Observes traffic and looks for security issues without attacking             |
| **Active Scan**  | Sends attacks (like SQL Injection, XSS) to find real vulnerabilities          |
| **Report Generation** | Creates a full security report after scanning                           |

## 7. Start a Quick Scan on Your Application
Suppose your app is hosted at:

```bash
http://your-small-app.com
```

Run a quick scan with ZAP:

```bash
./zap.sh -cmd -quickurl http://your-small-app.com -quickout report.html
```

This does:
- Crawling
- Passive Scan
- Active Scan
- Generates a detailed `report.html`

## 📄 8. Download or View the Scan Report
If you want to download the report to your laptop:

```bash
scp -i your-key.pem ubuntu@your-ec2-public-ip:/home/ubuntu/ZAP_2.14.0/report.html .
```

Or, you can view it inside the instance:

```bash
cat report.html
```

## 📌 Full Flow Summary

| Step | Task                                      |
|------|-------------------------------------------|
| 1    | Launch Ubuntu EC2                        |
| 2    | Open SSH (22) and optional HTTP (8080)   | 
| 3    | Install Java                             |
| 4    | Download and run OWASP ZAP               | 
| 5    | Spider, Passive Scan, Active Scan        |
| 6    | Generate Security Report                 |

## 🛠️ Notes:
- If your app needs login, you can configure authentication scripts inside ZAP (advanced setup).
- If you want GUI, you need to install a VNC server, but CLI is enough for now.
- No license cost — ZAP is fully open source and free forever.

## 🎯 Final One-Line Answer:
- ✅ Install ZAP on Ubuntu EC2,
- ✅ Run it in daemon mode,
- ✅ Scan your app using quick scan,
- ✅ Get a full vulnerability report easily.
