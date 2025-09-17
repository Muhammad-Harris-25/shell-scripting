#!/bin/bash



set -x
set -e
set -o pipefail
df -h

free -g

nproc

ps -ef |grep "amazon" | awk -F" " '{print $2}'


