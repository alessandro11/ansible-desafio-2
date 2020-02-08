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

on this repository there is a short file (hosts) describing mine mini
infrastructure, nevertheless in case needs to be adjusted the inventory,
please adjust. (for sure there is a global inventory :) and the
command above should be enough). The plays on behalf of each user are in the playbook.

# Results

At the end of the above command you should have a fully setup NodeJS
application, with the following futures:

* All the system packages required.
* An non privilege user in the system running the application.
* Credentials (pub key) to access and make easier deploy.
* The resilient service using the native systemd.
* Nginx http/https service running, see notes for https.¹
  * Reverse proxy
  * One Node worker per CPU.
  * Load balancing via nginx using round-robin policy.
* Script running each minute checking the health of the node app.
* Script running every midnight sending email about the routes access and frequencies.
* Script to generate a workload in the server.
* An easy switch of the versions among NodeJS via virtual env (NVM).
* Easy and safe deploy and rollback of the application, see notes.²

¹ Nginx has been setup with https, however an certificate needs to be
generate according to the domain. The challenge says to setup and not
generate mechanism to obtain it. However, it is easy using certboot
with acme challenge to generate the certificate by Let's
Encrypt.

About load balance: still the load balancing has been released via nginx. However, there
is a Master worker running, which also could do the job, so if
the reverse proxy points only to port 3000 (Master worker), this
will do load balance.

² The *deploy* and *rollback* has been build with shipit. So a
[shipitfile](https://github.com/alessandro11/desafio-2/blob/master/shipitfile.js)
must be setup, change the values of the following variables:
ps.: in case no changes has been made to create_user (Ansible variable)
do not change deployTo, THIS PATH MUST BE POINT TO THE ROOT OF THE
HOME OF THE USER HOLDING THE APPLICATION.

```
deployTo: <path to deploy>
tag: <annotation>
or
banch: <name>

servers: 'server@my_server_domain.com'

change the webserver home where it has been deployed
/home/{{ create_user }}/.nvm/nvm-exec npm install
```

*To run deploy:* ```npx shipit production deploy``` from the
 repository dir.
 
*To rollback:* ```npx shipit production rollback``` from the repository
 dir.
 

The deploy creates a directory on ```~/releases/20200208160632```
where the deploys are, and a symbolic link current point to some time
stamp dir on releases.

# Structure of this repository

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
