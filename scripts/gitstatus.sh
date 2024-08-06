gitstatus() {
  if [ -d .git ] || git rev-parse --git-dir > /dev/null 2>&1; then
    branch=$(git symbolic-ref --short HEAD 2>/dev/null || echo "(detached)")
    status=$(git status -s)
    echo "On branch: $branch"
    if [ -n "$status" ]; then
      echo "Changes:"
      echo "$status"
    else
      echo "Working directory clean"
    fi
  else
    echo "Not a Git repository"
  fi
}

# To use: run `gitstatus` in any Git repository
