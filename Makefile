# Variables
ENV_NAME := prompt
PYTHON3 := python3
# Check if direnv is installed
HAS_DIRENV := $(shell command -v direnv 2> /dev/null)

# Targets
.PHONY: setup compile sync update clean


# Virtual environment setup

ensurepip: check-setup
	@direnv exec ${PWD} ${PYTHON3} -m ensurepip --upgrade


install-piptools: check-setup
	@direnv exec ${PWD} ${PYTHON3} -m pip install pip-tools


compile: check-setup
	@direnv exec ${PWD} pip-compile --resolver=backtracking -o requirements.txt pyproject.toml
	@direnv exec ${PWD} pip-compile --resolver=backtracking --extra dev -o dev-requirements.txt pyproject.toml


sync: check-setup
	@direnv exec ${PWD} pip-sync requirements.txt dev-requirements.txt


update: check-setup
	@direnv exec ${PWD} pip-compile --upgrade


clean:
	rm -rf .envirc .direnv
	rm -f requirements.txt dev-requirements.txt


check-direnv:
	@if [ "$(HAS_DIRENV)" = "" ]; then \
		echo "Direnv is not installed. Please install direnv first."; \
		exit 1; \
	fi


check-setup: check-direnv
	@if [ ! -f .envrc ]; then \
		echo "Virtual environment not found. Please run 'make setup'."; \
		exit 1; \
	fi


setup-env: check-direnv
	@echo "Creating virtual environment..."

	@if [ ! -f .envrc ]; then \
		touch .envrc; \
	fi

	@if ! grep -q "layout $(PYTHON3)" .envrc; then \
		echo "layout $(PYTHON3)" >> .envrc; \
	fi

	@direnv allow
	@direnv reload


setup: setup-env ensurepip install-piptools compile sync 
	@echo "Setup complete."

# Development

