sysinfo() {
  echo "System Information Summary"
  echo "--------------------------"

  # CPU Load (same on both platforms)
  uptime_output=$(uptime)
  echo "CPU Load: $(echo "$uptime_output" | awk -F'[a-z]:' '{print $2}' | xargs)"

  # OS detection
  if [[ "$OSTYPE" == "darwin"* ]]; then
    # macOS
    memory=$(vm_stat | grep -E "Pages free|Pages active" | awk '{sum+=$3} END {printf "%.1f GB", sum/262144}')
    total_memory=$(sysctl -n hw.memsize | awk '{printf "%.1f GB", $1/1024/1024/1024}')
    echo "Memory Usage: ~$memory / $total_memory"
    disk=$(df -h / | awk 'NR==2 {print $3 "/" $2}')
    echo "Disk Usage: $disk"
    os=$(sw_vers -productName) $(sw_vers -productVersion)
    echo "OS: $os"
  else
    # Linux
    echo "Memory Usage: $(free -h | awk '/Mem/{print $3 "/" $2}')"
    echo "Disk Usage: $(df -h | awk '$NF=="/"{print $3 "/" $2}')"
    if command -v lsb_release &>/dev/null; then
      echo "OS: $(lsb_release -d | cut -f2-)"
    else
      echo "OS: $(uname -s)"
    fi
  fi
}
