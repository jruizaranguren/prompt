# Some utils for development

venv:
	python3.11 -m venv .venv

activate:
	. .venv/bin/activate

compile:
	pip-compile --resolver=backtracking -o requirements.txt pyproject.toml

sync:
	pip-sync requirements.txt

install:
	pip install -r requirements.txt

update:
	pip-compile --upgrade

clean:
	rm -rf .venv
	rm -f requirements.txt

make-activate-executable:
	chmod +x .venv/bin/activate

setup: venv make-activate-executable activate compile install

help:
	@echo "Makefile commands:"
	@echo "  venv      - create virtual environment"
	@echo "  activate  - activate virtual environment"
	@echo "  compile   - compile requirements"
	@echo "  sync      - sync requirements"
	@echo "  install   - install requirements"
	@echo "  update    - update requirements"
	@echo "  clean     - clean virtual environment"
	@echo "  setup     - setup virtual environment"