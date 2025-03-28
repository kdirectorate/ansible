<h1 align="center">Personal Ansible Playbooks</h1>

<p align="center">Ansible Playbooks and Roles to setup Ubuntu/Debian systems the way I like.
Mostly these are used for Virtual Machines I use in my daily work.</p>

![demo](./assets/demo.gif)

## debian-based

These will take a bone stock Debian 11 or Ubuntu 22 install and configure them.
You will need to have created a user and put your public key in the authorized_keys
for SSH access. That user will also need to be able to sudo. You can add them to
the /etc/sudoers.d if they aren't already by logging in as root:

    # As root
    echo "username ALL=(ALL:ALL) ALL" > /etc/sudoers.d/username

To install Ansible on the controller box (also debian):

    sudo apt-add-repository ppa:ansible/ansible
    sudo apt update
    sudo apt install ansible

### Inventory
Next you will need to setup an __inventory.yml__ file to describe your networked
machines. The format of the file looks like this:

    ungrouped:
        hosts:
            imsai.local:
                ansible_port: 22	
                ansible_user: hackerman
            uwork.local:
                ansible_port: 22	
                ansible_user: joesmith

You can find more information about configuring your inventory [here](https://docs.ansible.com/ansible/latest/inventory_guide/intro_inventory.html#inventory-basics-formats-hosts-and-groups).

### Configuration
Various options in the playbooks are set in __config.yml__. The file
__config.yml.example__ can be copied over to __config.yml__ to initialize
the file. You will probably want to edit the file and set the values based
on your situation.

### Bootstrap
To get a new machine bootstrapped as the Ansible controller follow these steps:

    sudo apt install git, openssh-server, ansible

    git clone https://github.com/kdirectorate/ansible.git
    cd ansible/debian-based
    copy config/config.example.yml config/config.yml
    editor config/config.yml

    touch files/htp.ovpn

    cat <<EOF
    ungrouped:
    hosts:
        uwork:
        ansible_connection: local 
        ansible_user: <yourusername>
    EOF

    ansible-playbook --ask-become-pass -i inventory.yml -K uwork.yml -l uwork


### Running a playbook
To run one of the playbooks:

    ansible-playbook -i inventory.yml -K pentest-pb.yml --ask-become-pass -l imsai

This will run the playbook __pentest-pb.yml__ using the given inventory file and 
limiting the run to only the "__imsai__" host.

I don't do it, but if you configure your sudo user to not require a password you
can take off the "--ask-become-pass". You will want to provide your own "inventory.yml"
file of course and the -pb.yml files are good for me, but are at best a working example
if you're trying to utilize these playbooks for yourself.

The playbooks themselves are relatively short with most of the work done in the
roles. You can turn off 'features' by editing the variables in the playbooks. Just
set the options variables to anything besides "yes" to turn that option off.

### (Playbook) basicdev

This playbook sets up a basic environment. I use it to configure
laptops as well as software development VMs that I spin up and throw
away on a regular basis. This is essentially my Ansible Controller
setup as well.

You can use *run-local.sh* to execute the Playbook on the local
computer.

### (Playbook) uwork:

For work purposes this installs and configures ipsec. You will have to
provide configuration files for this that are not included in the repo for
security reasons. Put the following files in ~/.local:

    - ipsec.conf
    - ipsec.secrets

More likely you aren't using _IPSec_ so you can turn off the install by setting the 
"ipsec" var to "no" in the playbook. The playbook also installs _OpenVPN_, but without
a configuration so you would need to provide that.

### (Playbook) pentest

This I use for pentesting. I like Ubuntu more than Kali. Since they are both Debian
based it is pretty easy to setup an Ubuntu install to do pentesting using the same
tools in the Kali distribution.

__HTB__

If you have a Hack The Box OpenVPN configuration file (.ovpn) then you can specify
it in your config.yml like so:

    hackthebox_config: "./files/htb.ovpn"

OpenVPN is installed by default. Your configuration file will be in ~/Downloads/.

## TODO:

[ ] Metasploit and feroxbuster are installed by scripts, and the scripts are
getting run every time. It would be better if they only ran when needed.

## Built With
- Ansible

## Author
**Kirby Angell**
