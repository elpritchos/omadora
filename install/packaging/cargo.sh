#!/bin/bash

# Packages for cargo builds 
sudo dnf install -y \
  cargo \
  clang \
  pipewire-devel

# Build cargo bins
cargo install \
  bluetui \
  cargo-update \
  eza \
  impala \
  wiremix
