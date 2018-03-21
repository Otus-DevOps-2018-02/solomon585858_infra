#!/bin/bash
gcloud compute instances create reddit-app --machine-type=g1-small --tags puma-server --restart-on-failure --zone europe-west1-b --image reddit-full-1511608151 --image-family reddit-full
