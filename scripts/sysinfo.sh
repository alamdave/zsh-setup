
sysinfo() {
  echo "System Information Summary"
  echo "--------------------------"
  echo "CPU Load: $(uptime | awk -F'[a-z]:' '{ print $2}')"
  echo "Memory Usage: $(free -h | awk '/Mem/{print $3 "/" $2}')"
  echo "Disk Usage: $(df -h | awk '$NF=="/"{print $3 "/" $2}')"
  echo "OS: $(lsb_release -d | cut -f2-)"
}

# To use: run `sysinfo` to display system info
