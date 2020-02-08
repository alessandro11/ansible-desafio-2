# Challenge - Part 2

This is an Ansible playbook to deploy the challenge part two from
Linx Impulse. This tool has been chosen due to the fact that the Cloud
Engineering position claims knowledge about this tool.


.
├── setup_desafio-2
│   └── vars
├────── └── default.yml - default variables used by Ansible.
│
├── nvmenv        - file with snippet to load the environment of nvm/node.
├── nvmrc         - file with the version to be used. It has been locked for LTS.
├── playbook.yml  - main file with all those plays to deploy completely the challenge two.
├── proxy.conf    - snippet for nginx, headers for reverse proxy.
├── webserver     - default variables such as NODE_ENV; used for some scripts.
├── webserver.com - setup file for nginx virtual host.


