#! /bin/bash

#Script for restarting a service via systemctl

systemctl stop $1
systemctl start $1