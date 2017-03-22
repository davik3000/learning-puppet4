# -*- mode: ruby -*-
# vi: set ft=ruby :

# Vagrantfile API/syntax version. Don't touch unless you know what you're doing!
VAGRANTFILE_API_VERSION = "2"
Vagrant.require_version ">= 1.5.2"

# DART moved provision script in config/scripts/learning-puppet.sh

Vagrant.configure(VAGRANTFILE_API_VERSION) do |config|
  # #####
  # Common configuration variables
  # #####
  _provisionFolder_config_hostPath = "./config"
  _provisionFolder_config_guestPath = "/tmp/vagrant/config"
  _provisionFolder_scripts_guestPath = _provisionFolder_config_guestPath + "/scripts"

  _provisionScript_clean_hostPath = "./config/clean.sh"
  _provisionScript_clean_args = _provisionFolder_config_guestPath

  _provisionScript_provision_hostPath = "./config/provision.sh"
  _provisionScript_provision_args = _provisionFolder_scripts_guestPath

  #_sharedFolder_common_hostPath = "./vboxsf"
  #_sharedFolder_common_guestPath = "/opt/vboxsf"

  # #####
  # VM definitions
  # #####
  config.vm.box = "puppetlabs/centos-7.2-64-nocm"

  config.vm.provider :virtualbox do |vb|
    vb.customize ["modifyvm", :id, "--natdnsproxy1", "off"]
    vb.customize ["modifyvm", :id, "--natdnshostresolver1", "off"]
  end

  # keep using Vagrant insecure key
  config.ssh.insert_key = false

  # clients
  config.vm.define "client", primary: true do |client|
    client.vm.hostname = "client.example.com"
    client.vm.network :private_network, ip: "192.168.250.10", virtualbox__intnet: true

    client.vm.provider :virtualbox do |vb|
      vb.name = "learning-puppet_client"
    end
    # #####
    # provisioning
    # #####
    # DART clean from previous provision
    client.vm.provision :shell do |s|
      s.path = _provisionScript_clean_hostPath
      s.args = [_provisionScript_clean_args]
    end
    # DART send config
    client.vm.provision :file do |f|
      f.source = _provisionFolder_config_hostPath
      f.destination = _provisionFolder_config_guestPath
    end
    # DART apply config
    client.vm.provision :shell do |s|
      s.path = _provisionScript_provision_hostPath
      s.args = [_provisionScript_provision_args]
    end
  end

  (1..3).each do |i|
    config.vm.define "web#{i}", primary: true do |webserver|
      webserver.vm.hostname = "web#{i}.example.com"
      webserver.vm.network :private_network, ip: "192.168.250.2#{i}", virtualbox__intnet: true

      webserver.vm.provider :virtualbox do |vb|
        vb.name = "learning-puppet_web#{i}"
      end
      # #####
      # provisioning
      # #####
      # DART clean from previous provision
      webserver.vm.provision :shell do |s|
        s.path = _provisionScript_clean_hostPath
        s.args = [_provisionScript_clean_args]
      end
      # DART send config
      webserver.vm.provision :file do |f|
        f.source = _provisionFolder_config_hostPath
        f.destination = _provisionFolder_config_guestPath
      end
      # DART apply config
      webserver.vm.provision :shell do |s|
        s.path = _provisionScript_provision_hostPath
        s.args = [_provisionScript_provision_args]
      end
    end
  end

  # A puppetmaster
  config.vm.define "puppetmaster", autostart: false do |puppetmaster|
    puppetmaster.vm.hostname = "puppetmaster.example.com"
    puppetmaster.vm.network :private_network, ip: "192.168.250.5", virtualbox__intnet: true

    puppetmaster.vm.provider :virtualbox do |vb|
      vb.name = "learning-puppet_puppetmaster"
    end
    # #####
    # provisioning
    # #####
    # DART clean from previous provision
    puppetmaster.vm.provision :shell do |s|
      s.path = _provisionScript_clean_hostPath
      s.args = [_provisionScript_clean_args]
    end
    # DART send config
    puppetmaster.vm.provision :file do |f|
      f.source = _provisionFolder_config_hostPath
      f.destination = _provisionFolder_config_guestPath
    end
    # DART apply config
    puppetmaster.vm.provision :shell do |s|
      s.path = _provisionScript_provision_hostPath
      s.args = [_provisionScript_provision_args]
    end
  end

  # Puppet Server
  config.vm.define "puppetserver", autostart: false do |puppetserver|
    puppetserver.vm.hostname = "puppetserver.example.com"
    puppetserver.vm.network :private_network, ip: "192.168.250.6", virtualbox__intnet: true

    puppetserver.vm.provider :virtualbox do |vb|
      vb.name = "learning-puppet_puppetserver"
      vb.memory = 1024
    end
    # #####
    # provisioning
    # #####
    # DART clean from previous provision
    puppetserver.vm.provision :shell do |s|
      s.path = _provisionScript_clean_hostPath
      s.args = [_provisionScript_clean_args]
    end
    # DART send config
    puppetserver.vm.provision :file do |f|
      f.source = _provisionFolder_config_hostPath
      f.destination = _provisionFolder_config_guestPath
    end
    # DART apply config
    puppetserver.vm.provision :shell do |s|
      s.path = _provisionScript_provision_hostPath
      s.args = [_provisionScript_provision_args]
    end
  end

  # Puppet Dashboard
  config.vm.define "dashboard", autostart: false do |puppetserver|
    puppetserver.vm.hostname = "dashserver.example.com"
    puppetserver.vm.network :private_network, ip: "192.168.250.7", virtualbox__intnet: true

    puppetserver.vm.provider :virtualbox do |vb|
      vb.name = "learning-puppet_dashboard"
      vb.memory = 1024
    end
    # #####
    # provisioning
    # #####
    # DART clean from previous provision
    puppetserver.vm.provision :shell do |s|
      s.path = _provisionScript_clean_hostPath
      s.args = [_provisionScript_clean_args]
    end
    # DART send config
    puppetserver.vm.provision :file do |f|
      f.source = _provisionFolder_config_hostPath
      f.destination = _provisionFolder_config_guestPath
    end
    # DART apply config
    puppetserver.vm.provision :shell do |s|
      s.path = _provisionScript_provision_hostPath
      s.args = [_provisionScript_provision_args]
    end
  end
end
