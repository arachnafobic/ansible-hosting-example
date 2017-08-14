#!/usr/bin/env bash

users=( foo bar baz qux )


# Generate keys used in this example playbook
for i in "${users[@]}"
do
	echo "Adding key for example user $i"
        ssh-keygen -f keys/$i -q -N ""
        cp keys/$i.pub ansible/roles/hosting/files/keys/
done
