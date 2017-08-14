#!/usr/bin/env bash

# Update box to latest and cleanup apt
apt-get update
apt-get -y install apt-transport-https aptitude
apt-get -y upgrade
apt-get -y autoclean
apt-get -y autoremove
