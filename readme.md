
    File        : README.md
    Maintainer  : Remco v. Hest <remco@arachnafobic.org>

### Description

    Ansible Hosting Example
    
    Goal:
     Have a Debian 8/9/both with the following :
     
      - Each host has 2+ users and atleast 4 vhosts total
      - Each user has 2+ sites using nginx with php, running with the user's rights
      - Each user can't access other users files.
      - Each site has it's own vhost(s)
      - Each host has access to 2 Major php versions (5.6 + 7.0, 7.1, 7.2)
      - Each site has a default working wordpress deployed on it.


### Usage

    Get the vms up and running, and run the playbook with the following

    $ vagrant up    # Starts 2 vms, debian 8 and 9.
    $ ./keygen.sh   # Generate mock sshkeys used for example users.
    $ cd ansible
    $ ./run.sh      # ansible-playbook runner
    
    At the end of the playbook, the final task will output all the urls for each
    installed site, using xip.io.
