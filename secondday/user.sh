#!/bin/bash





read -p "enter username:" username


echo "you entered $username"

sudo useradd -m $username

echo "New User added"
