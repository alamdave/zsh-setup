gitstatus() {
  if ! git rev-parse --git-dir &>/dev/null; then
    echo "Error: Not a git repository" >&2
    return 1
  fi

  local branch=$(git symbolic-ref --short HEAD 2>/dev/null || echo "(detached)")
  local status=$(git status -s)

  echo "Branch: $branch"

  if [ -z "$status" ]; then
    echo "Status: Working directory clean"
  else
    echo "Status:"
    echo "$status"
  fi
}
