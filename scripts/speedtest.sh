speedtest() {
  if ! command -v speedtest-cli &> /dev/null; then
    echo "speedtest-cli is not installed. Installing..."
    sudo apt-get install -y speedtest-cli
  fi

  speedtest-cli --simple
}