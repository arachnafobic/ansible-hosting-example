base_cfg = {
  name:       'vm',
  release:    'jessie64',
  version:    '8.9.0',
  host:       'vm.example.com',
  ip:         'dhcp',
  sshport:    '2222',
  memory:     '2048',
  shares:   {
    'shared' => '/home/vagrant/shared',
    'scripts' => '/home/vagrant/scripts',
  },
  forwards: {
    8080 => 80,
  },
  fwd_x:      false,
  gui:        false,
  sshagent:   false,
  defaultvm:  false,
}

boxes = [
  {
    name:       'vm-debian8',
    host:       'vm-debian8.example.com',
    sshport:    '2210',
    memory:     '2048',
    defaultvm:  true,
    forwards: {
      8080 => 80,
    },
  },
  {
    name:       'vm-debian9',
    release:    'stretch64',
    version:    '9.1.0',
    host:       'vm-debian9.example.com',
    sshport:    '2220',
    memory:     '2048',
    defaultvm:  false,
    forwards: {
      8180 => 80,
    },
  },
]

Vagrant::Config.run('2') do |config|
  boxes.each do |box|
    cfg   = base_cfg.merge box
    name  = ENV['CURRENT_BOX'] = cfg[:name]

    # Turn vbguest addon off
    if Vagrant.has_plugin? "vagrant-vbguest"
      config.vbguest.no_install  = true
      config.vbguest.auto_update = false
      config.vbguest.no_remote   = true
    end

    config.vm.define name, primary: cfg[:defaultvm] do |config|

      # Set Box
      config.vm.box = "debian/#{cfg[:release]}"
      config.vm.box_version = cfg[:version]
      config.vm.box_check_update = true
      config.vm.hostname = cfg[:host]

      # SSH Options
      config.ssh.forward_x11 = cfg[:fwd_x]
      config.ssh.forward_agent = cfg[:sshagent]

      # Virtual Box Options
      config.vm.provider :virtualbox do |vb|
        vb.gui = cfg[:gui]
        vb.customize ["modifyvm", :id, "--memory", cfg[:memory]] if cfg[:memory]
      end

      # Set Network
      if cfg[:ip] == 'dhcp'
        config.vm.network :private_network, type: cfg[:ip]
      elsif cfg[:ip]
        config.vm.network :private_network, ip: cfg[:ip]
      end

      # Disable default ssh forward and set our own
      if cfg[:sshport] != ''
        config.vm.network :forwarded_port, guest: 22, host: 2222, id: "ssh", disabled: true
        config.vm.network :forwarded_port, guest: 22, host: cfg[:sshport], auto_correct: true
      end

      # Set Custom Port Forwards
      cfg[:forwards].each do |k, v|
        config.vm.network :forwarded_port, guest: v, host: k
      end

      # Mount shares (create when missing)
      config.vm.synced_folder '.', '/vagrant', disabled: true
      if cfg[:shares] != ''
        cfg[:shares].each do |k,v|
          config.vm.synced_folder k, v, create: true, type: "rsync"
        end
      end

      config.vm.post_up_message = ""

      # Run provision (just a run of apt-get update/upgrade/clean)
      config.vm.provision "shell", inline: "/home/vagrant/scripts/provision.sh"

    end
  end
end

