require "vagrant"

module VagrantPlugins
    module CommandDns
        class Plugin < Vagrant.plugin("1")
            name "dns command"
            description "The `dns` gives you a way to manage dns control of boxes"
            
            activated do
                require File.expand_path("../vagrant-dns/restart_middleware",__FILE__)
            end
            
            command("dns") do
                require File.expand_path("../vagrant-dns/command",__FILE__)
                VagrantDNS::Command
            end
            
            config ("dns") do
                require File.expand_path("../vagrant-dns/config",__FILE__)
                VagrantDNS::Config
            end
            
            action_hook(:up) do |seq|
                seq.insert_after ::Vagrant::Action::VM::Customize, VagrantDNS::RestartMiddleware       
            end
            
            action_hook(:reload) do |seq|
                seq.insert_after ::Vagrant::Action::VM::Customize, VagrantDNS::RestartMiddleware       
            end
        end
    end
end
