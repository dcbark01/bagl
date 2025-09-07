#!/usr/bin/env just --justfile

alias s := sync
alias f := format
alias l := lint
alias t := test
alias pc := precommit
alias bg := baml-generate

set dotenv-load := true

OPENAI_API_KEY := `echo $OPENAI_API_KEY`  # OPENAI_API_KEY is a required environment variable


# List available recipes
default:
  @just --list

# Install/sync
sync:
  uv sync

# Run formatter
format:
  uv run ruff format

# Run linter
lint:
  uv run ruff check --fix

# Run tests
test:
  uv run pytest -v --cov=src --cov-report=html --cov-report=term

# Run format/lint/check
precommit:
  just sync
  just format
  just lint
  just test

# Generate baml client code
baml-generate:
  uv run baml-cli generate

# Remove cached files
clean *args:
  uv run pyclean . \
    --debris cache coverage package pytest ruff \
    --yes \
    -e '.coverage' \
    {{ args }}
  uv cache prune
