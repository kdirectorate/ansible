#!/bin/bash

ansible-playbook -i config/inventory.yml --ask-become-pass --connection=local -l localhost --extra-vars "ansible_user=${USER}" basicdev.yml
