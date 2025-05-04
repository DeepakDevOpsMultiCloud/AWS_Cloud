# Prerequisites for Installing and Configuring OWASP ZAP on AWS EC2

## 1. EC2 Instance
- Instance type: `t2.medium` or higher
- OS: `Ubuntu 20.04` or `Ubuntu 22.04` (recommended)

## 2. Security Group Settings
- Allow **SSH** (Port `22`) - for remote login
- Allow **ZAP GUI Port** (e.g., `8080`) - if accessing ZAP remotely (optional)

## 3. Installed Packages
- **Java 11** or higher
- **wget** or **curl** (for downloading ZAP)
- **GUI Software** (like `X11`, if GUI access is needed)

## 4. Storage
- Minimum **8 GB** of disk space

## 5. RAM
- Minimum **4 GB RAM** for smooth scanning

## 6. Internet Access
- Outbound internet enabled to download ZAP and dependencies

## 7. (Optional) VNC Server
- Install and configure a **VNC server** if full GUI remote access is needed

