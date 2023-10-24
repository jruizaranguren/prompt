#!/bin/bash

# Function to check if a command exists
command_exists() {
  command -v "$1" >/dev/null 2>&1
}

# Check if direnv is already installed
if command_exists direnv; then
  echo "Direnv is already installed."
else
  # Install direnv using package manager (apt)
  echo "Installing direnv..."
  sudo apt update
  sudo apt install -y direnv
fi

#!/bin/bash

BASHRC_PATH="$HOME/.bashrc"

# Check if the show_virtual_env function is present in .bashrc
if ! grep -qF "show_virtual_env()" "$BASHRC_PATH"; then
    # Append the show_virtual_env function to .bashrc
    cat << 'EOF' >> "$BASHRC_PATH"
show_virtual_env() {
  if [[ -n "$VIRTUAL_ENV" && -n "$DIRENV_DIR" ]]; then
    project_path=$(dirname "$(dirname "$VIRTUAL_ENV")")
    echo "($(basename $project_path))"
  else
    echo ""
  fi
}

DEFAULT_PS1=$PS1

update_prompt() {
  PS1="$(show_virtual_env)${DEFAULT_PS1}"
}

export -f show_virtual_env
PROMPT_COMMAND='update_prompt'
EOF

    echo "show_virtual_env configuration added to .bashrc"
else
    echo "show_virtual_env configuration is already present in .bashrc"
fi

# Check if the eval "$(direnv hook bash)" line is present in .bashrc
if ! grep -qF "eval \"\$(direnv hook bash)\"" "$BASHRC_PATH"; then
    # Append the eval "$(direnv hook bash)" line to .bashrc
    echo 'eval "$(direnv hook bash)"' >> "$BASHRC_PATH"
    echo "direnv hook added to .bashrc"
else
    echo "direnv hook is already present in .bashrc"
fi
