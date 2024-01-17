<h1 align="center">Personal Ansible Playbooks</h1>

<p align="center">Ansible Playbooks and Roles to setup Ubuntu/Debian systems the way I like.
Mostly these are used for Virtual Machines I use in daily work projects.</p>

## debian-based

These will take a bone stock Debian 11 or Ubuntu 22 install and configure them.
You will need to have created a user and put your public key in the authorized_keys
for SSH access. That user will also need to be able to sudo. You can add them to the
sudoers group if they aren't already by logging in as root:

    usermod -a -G sudoers username

To install Ansible on the controller box (also debian):

    sudo apt-add-repository ppa:ansible/ansible
    sudo apt update
    sudo apt install ansible

### Inventory
Next you will need to setup an __inventory.ini__ file to describe your networked
machines. The format of the file looks like this:

[pentest]
imsai.local	ansible_port=22	ansible_user=hackerman
[uwork]
uwork.local	ansible_port=22	ansible_user=joesmith

### Configuration
Various options in the playbooks are set in __config.yml__. The file
__config.yml.example__ can be copied over to __config.yml__ to initialize
the file. You will probably want to edit the file and set the values based
on your situation.

### Running a playbook
To run one of the playbooks:

    ansible-playbook -i inventory.ini -K pentest-pb.yml --ask-become-pass

I don't do it, but if you configure your sudo user to not require a password you
can take off the "--ask-become-pass". You will want to provide your own "inventory.ini"
file of course and the -pb.yml files are good for me, but are at best a working example
if you're trying to utilize these playbooks for yourself.

The playbooks themselves are relatively short with most of the work done in the
roles. You can turn off 'features' by editing the variables in the playbooks. Just
set the options variables to anything besides "yes" to turn that option off.

uwork-pb.yml    - Playbook for general Ubuntu workstation
pentest-pb.yml  - Playbook for Pentesting workstation

### uwork-pb:

For work purposes this installs and configures ipsec. You will have to
provide configuration files for this that are not included in the repo for
security reasons. Put the following files in ~/.local:

- ipsec.conf
- ipsec.secrets

More likely you aren't using _IPSec_ so you can turn off the install by setting the 
"ipsec" var to "no" in the playbook. The playbook also installs _OpenVPN_, but without
a configuration so you would need to provide that.

### pentest-pb

This I use for pentesting. I like Ubuntu more than Kali. Since they are both Debian
based it is pretty easy to setup an Ubuntu install to do pentesting using the same
tools in the Kali distribution.

No special setup instructions here. If you run the playbook, you get some pentesting
tools. It's simple.

## Built With
- Ansible

## Future Updates

- [ ] The pentest playbook isn't complete. Some repos Kali installs by default are
not being installed.

## Author
**Kirby Angell**
