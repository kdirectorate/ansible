#!/bin/bash

ansible-playbook --ask-become-pass --connection=local --extra-vars "ansible_user=${USER}" playbooks/basicdev.yml
