SHELL := /bin/bash

VENV = ./.venv

export PATH := $(VENV)/bin:$(PATH)

.PHONY: activate
activate:
ifneq (,$(wildcard $(VENV)))
	source $(VENV)/bin/activate
else
	python3 -m venv $(VENV) && source $(VENV)/bin/activate
endif

.PHONY: test
test: flake radon isort black pytest

.PHONY: flake
flake:
		@flake8 .

.PHONY: black
black:
		@black . --check --exclude=".venv"


.PHONY: radon
radon:
		@radon mi --ignore node_modules .

.PHONY: isort
isort:
		@isort --check-only .

.PHONY: pytest
pytest:
		pytest -v tests/

.PHONY: install-requirements
install-requirements: activate
		pip install -r requirements.txt