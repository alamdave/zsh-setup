#!/usr/bin/env bash

set -euo pipefail

REPO_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
OS_TYPE="$(uname)"
HOME_SCRIPTS_DIR="${HOME}/scripts"
HOME_BIN_DIR="${HOME}/.local/bin"
BOOTSTRAP_TARGET="${HOME_BIN_DIR}/bootstrap-zsh"
LEGACY_SCRIPTS=(
  "${HOME_SCRIPTS_DIR}/bootstrap-zsh.sh"
  "${HOME_SCRIPTS_DIR}/updateGitZsh.sh"
  "${HOME_SCRIPTS_DIR}/gitstatus.sh"
)

install_homebrew() {
  if ! command -v brew >/dev/null 2>&1; then
    echo "Homebrew is not installed. Installing Homebrew..."
    /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
  fi
}

install_package() {
  local package_name="$1"

  if [[ "${OS_TYPE}" == "Linux" ]]; then
    if ! command -v "${package_name}" >/dev/null 2>&1; then
      echo "Installing ${package_name}..."
      sudo apt update
      sudo apt install -y "${package_name}"
    fi
  elif [[ "${OS_TYPE}" == "Darwin" ]]; then
    install_homebrew
    if ! command -v "${package_name}" >/dev/null 2>&1; then
      echo "Installing ${package_name}..."
      brew install "${package_name}"
    fi
  else
    echo "Unsupported OS type: ${OS_TYPE}" >&2
    exit 1
  fi
}

backup_if_regular_file() {
  local target_path="$1"

  if [[ -e "${target_path}" && ! -L "${target_path}" ]]; then
    local backup_path="${target_path}.bak.$(date +%Y%m%d%H%M%S)"
    mv "${target_path}" "${backup_path}"
    echo "Backed up ${target_path} -> ${backup_path}"
  fi
}

link_file() {
  local source_path="$1"
  local target_path="$2"

  mkdir -p "$(dirname "${target_path}")"

  if [[ -L "${target_path}" && "$(readlink "${target_path}")" == "${source_path}" ]]; then
    echo "Already linked: ${target_path}"
    return 0
  fi

  backup_if_regular_file "${target_path}"
  rm -f "${target_path}"
  ln -s "${source_path}" "${target_path}"
  echo "Linked ${target_path} -> ${source_path}"
}

ensure_shell_registered() {
  if [[ "${OS_TYPE}" != "Darwin" ]]; then
    return 0
  fi

  local zsh_path
  zsh_path="$(command -v zsh)"

  if [[ -n "${zsh_path}" ]] && ! grep -qx "${zsh_path}" /etc/shells; then
    echo "${zsh_path}" | sudo tee -a /etc/shells >/dev/null
  fi
}

set_default_shell() {
  local zsh_path
  zsh_path="$(command -v zsh)"

  if [[ -n "${zsh_path}" && "${SHELL:-}" != "${zsh_path}" ]]; then
    echo "Changing default shell to Zsh..."
    chsh -s "${zsh_path}"
  fi
}

main() {
  echo "Setting up your Zsh environment..."

  install_package zsh
  install_package git

  mkdir -p "${HOME_SCRIPTS_DIR}" "${HOME_BIN_DIR}"

  link_file "${REPO_DIR}/.zshrc" "${HOME}/.zshrc"
  link_file "${REPO_DIR}/.p10k.zsh" "${HOME}/.p10k.zsh"

  local script
  for script in "${REPO_DIR}"/scripts/*.sh; do
    [[ -e "${script}" ]] || continue
    link_file "${script}" "${HOME_SCRIPTS_DIR}/$(basename "${script}")"
  done

  local legacy_path
  for legacy_path in "${LEGACY_SCRIPTS[@]}"; do
    rm -f "${legacy_path}" "${legacy_path}.zwc"
  done

  rm -f "${HOME_SCRIPTS_DIR}"/*.zwc

  link_file "${REPO_DIR}/bin/bootstrap-zsh" "${BOOTSTRAP_TARGET}"
  chmod +x "${BOOTSTRAP_TARGET}"

  "${BOOTSTRAP_TARGET}"

  ensure_shell_registered
  set_default_shell

  echo "Zsh environment setup complete."
  echo "Start a new shell with: exec zsh"
  echo "If the prompt looks wrong, install a Nerd Font for Powerlevel10k."
}

main "$@"
