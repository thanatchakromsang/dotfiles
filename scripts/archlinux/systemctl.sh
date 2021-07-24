#!/bin/bash

sudo systemctl enable --now bluetooth.service
sudo systemctl enable --now NetworkManager.service
sudo systemctl enable --now docker.service

sudo systemctl --system daemon-reload

