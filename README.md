# Challenge - Part 2

This is an Ansible playbook to deploy the challenge part two from
Linx Impulse. This tool has been chosen due to the fact that the Cloud
Engineering position claims knowledge about this tool.

# Environment used

This playbook has been tested under a Virtual Machine:
<pre>
Distributor ID:	Ubuntu
Description:	Ubuntu 18.04.4 LTS
Release:	18.04
Codename:	bionic

Linux webserver 4.15.0-76-generic #86-Ubuntu SMP Fri Jan 17 17:24:28 UTC 2020 x86_64 x86_64 x86_64 GNU/Linux

Ansible
ansible-playbook 2.9.4
python version = 3.8.1
</pre>

# Run

To run this playbook execute:

```
ansible-playbook playbook.yml -l <server>
```

on this repository there is a short file describing mine mini
infrastructure, nevertheless in case needs to be adjusted the inventory,
please adjust. (Remind -i <inventory_file>).

# Results

At the end of the command above you should have a fully setup node
application, with the following futures:

--* All the system packages required.
--* An non privilege user in the system running the application.
--* Credentials (pub key) to access and make easier deploy.
--* The service start resilient using the native systemd.
--* Nginx http/https service running, see notes for https.¹
--* Script running each minute checking the health of the node app.
--* Script running every midnight sending email about the routes access and frequencies.
--* Script to generate a workload in the server.
--* An easy switch of the versions among NodeJS via virtual env (NVM).
--* Easy and safe deploy and rollback of the application, see notes.²

¹ Nginx has been setup with https, however an certificate needs to be
generate according to the domain. The challenge says to setup and not
generate mechanism to generate it. However, it is easy using certboot
with acme challenge to generate the certificate by Let's Encrypt.

² The *deploy* and *rollback* has been build with shipit. So a
[shipitfile](https://github.com/alessandro11/desafio-2/blob/master/shipitfile.js)
must be setup, change the value of the following variables:
ps.: in case no changes has been made to create_user ansible variable
do not change deployTo, THIS PATH SHOULD NOT POINT TO THE REPOSITORY DIR.

```
deployTo: <path to deploy>
tag: <annotation>
or
banch: <name>

servers: 'server@my_server_domain.com'

change the webserver home where has been deployed
/home/{{ create_user }}/.nvm/nvm-exec npm install
```

*To run deploy:* ```npx shipit production deploy``` from the repository dir.
*To rollback:* ```npx shipit master rollback``` from the repository dir.

The deploy creates a directory on ```~/releases/20200208160632```
where the deploys are, and a symbolic link current point to some time
stamp dir on releases.

<pre>
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
</pre>
