#!/bin/bash

# Docker
sudo usermod -a -G docker $USER

# Sudoer
sudo usermod -a -G wheel $USER

# Lightcontrol group
sudo usermod -a -G video $USER

