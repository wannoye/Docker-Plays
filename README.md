# Docker Plays

## "install_docker.yml" Ansible Playbook

Installs the Docker service and any needed dependencies.<br/>
Firewall rules are created for Docker Swarm connections.<br/>
A 'docker' group is createdto allow non-root administration.<br/>
Works with Debian and RedHat based linux servers.

### Requires:

- An admin username and password assigned to the 'ansible_user' and 'ansible_become_pass' vars in 'group_vars/all.yml'

### Usage:

```ansible-playbook install_docker.yml -i inventory --ask-vault-pass```

## "install_pihole.yml" Ansible Playbook

Installs and configures PiHole in Docker.<br/>
Firewall rules are created for DNS, DHCP, and Web access.<br/>
Configuration files are backed up (pihole -a -t) to '/var/lib/docker/PiHole'.<br/>
Running instances are stopped, and docker images are refreshed.<br/>
After installation, the web console is available at: ```https://<IP>/admin```<br/>
The Administrator password is set by the 'user_pass' var in 'group_vars/all.yml'.<br/>
Works with Debian and RedHat based linux servers.

### Requires:

- The following variables assigned in 'group_vars/all.yml':<br/>
    - An admin username and password assigned to 'ansible_user' and 'ansible_become_pass'<br/>
    - A password for the admin web console assigned to 'user_pass'

### Usage:

```ansible-playbook install_pihole.yml -i inventory --ask-vault-pass```

## "install_plex.yml" Ansible Playbook
Installs and configures Plex Media Server in Docker.<br/>
Firewall rules are created to allow remote access.<br/>
Running instances are stopped, and docker images are refreshed.<br/>
The Plex library database is backed up and optionally restored.<br/>
After installation Plex can be accessed at: ```http: - or - https://<IP>:32400/web```<br/>
Works with Debian and RedHat based linux servers.

### Requires:

- An admin username and password assigned to the 'ansible_user' and 'ansible_become_pass' vars in 'group_vars/all.yml'<br/>
- The 'existing_server' var specifies which server's database is backed up.<br/>
- Database backup file name and destination is specified with the 'backup' variable.<br/>
- A database can be restored using the boolean 'restore_db' var while 'db_dir' sets the location.

### Usage:

```ansible-playbook install_plex.yml -i inventory --ask-vault-pass```

## "install_cups.yml" Ansible Playbook
Installs and configures a CUPS server in Docker.<br/>
The 'cupsd.conf' and 'printers.conf' files are backed up to the '{{ share }}' directory<br/>
Print, copy, and scan scripts written to quickly perform these actions from the CLI.<br/>
After installation, the web console is available at: ```https://<IP>:613/admin (Username: 'print')```

Note: The print, copy, and scan Scripts have not yet been implemented in the install_cups.yml playbook.<br/>
Script Syntax: <br/>
 - Type "prnt /path/to/file" to print a file via command line.<br/>
 - Type "scan" to scan a file after placing it in the scanner bed. <br/>
 - Type "copy" to scan then print a document after placing it in the scanner bed.<br/>

Scanned and coppied images are saved to {{ shared }}/Scans.

### Requires:
- The following variables assigned in 'group_vars/all.yml':<br/>
    - An admin username and password assigned to 'ansible_user' and 'ansible_become_pass'<br/>
    - A password for the admin web console ('print' user) assigned to 'user_pass'<br/>
- The 'cups_dir' var specifies the local directory for the 'printer.config' and 'cupsd.conf' config files.<br/>
- The 'share' var defines a location for backups and scanned images to be saved.<br/>
- Configuration files can be restored from the archive using the boolean 'restore_config' var.<br/>

### Usage:

```ansible-playbook install_cups.yml -i inventory --ask-vault-pass```