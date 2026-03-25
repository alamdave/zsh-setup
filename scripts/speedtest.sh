speedtest() {
  if ! command -v speedtest-cli &>/dev/null; then
    echo "Error: speedtest-cli is not installed" >&2
    echo ""
    echo "To install, run one of the following:"
    if [[ "$OSTYPE" == "darwin"* ]]; then
      echo "  brew install speedtest-cli"
    else
      echo "  sudo apt install speedtest-cli"
      echo "  # or"
      echo "  pip install speedtest-cli"
    fi
    return 1
  fi

  speedtest-cli --simple
}