IP_SERVER = "192.168.99.20"
IP_WORKER = "192.168.99.3"
VM_NETWORK = "vboxnet2"

Vagrant.configure("2") do |config|
  config.vm.box = "ubuntu/bionic64"
  config.vm.provider "virtualbox" do |vb|
    vb.linked_clone = true
    vb.cpus = 1
    vb.memory = "2048"
  end
  config.vm.provision "file", source: "./k3s", destination: "~/k3s"
  config.vm.provision "file", source: "./id_rsa", destination: "~/.ssh/id_rsa"
  config.vm.provision "file", source: "./id_rsa.pub", destination: "~/.ssh/id_rsa.pub"
  config.vm.define "server" do |node|
    node.vm.hostname = "server"
    node.vm.network "private_network", ip: IP_SERVER, virtualbox__hostnet: VM_NETWORK, adapter: 2
    node.vm.provision "file", source: "./k3s-server.service", destination: "~/k3s-server.service"
    node.vm.provision "shell" do |s|
      s.env = {NODE_IP:IP_SERVER,NODE_EXTERNAL_IP:IP_SERVER,NODE_NAME:"server"}
      s.path = "./k3s-server-init.sh"
    end
  end

  (1..3).each do |i|
    config.vm.define "worker#{i}" do |node|
      node.vm.hostname = "worker#{i}"
      node.vm.network "private_network", ip: "#{IP_WORKER}#{i}", virtualbox__hostnet: VM_NETWORK, adapter: 2
      node.vm.provision "file", source: "./k3s-agent.service", destination: "~/k3s-agent.service"
      node.vm.provision "shell" do |s|
        s.env = {NODE_IP:"#{IP_WORKER}#{i}",NODE_EXTERNAL_IP:"#{IP_WORKER}#{i}",NODE_NAME:"worker#{i}",SERVER_IP:IP_SERVER}
        s.path = "./k3s-agent-init.sh"
      end
    end
  end
end
