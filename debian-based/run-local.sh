#!/bin/bash

ansible-playbook --ask-become-pass --connection=local --extra-vars "ansible_user=${USER}" basicdev-pb.yml
