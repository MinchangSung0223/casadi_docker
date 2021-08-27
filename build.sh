#!/bin/bash
docker build -t casadi:latest --build-arg ssh_prv_key="$(cat ~/.ssh/id_ed25519)" --build-arg ssh_pub_key="$(cat ~/.ssh/id_ed25519.pub)" .

