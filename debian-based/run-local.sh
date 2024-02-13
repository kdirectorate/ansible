#!/bin/bash

ansible-playbook --ask-become-pass --connection=local --extra-vars "ansible_user=${USER}" baremetal-pb.yml
