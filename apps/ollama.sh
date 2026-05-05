#!/bin/bash

yay -S ollama-cuda

sudo systemctl enable --now ollama-cuda.service
