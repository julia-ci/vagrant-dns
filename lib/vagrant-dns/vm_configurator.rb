module VagrantDNS
  class VmConfigurator
    def initialize(app, env)
      @app = app
      @env = env
    end
  
    def call(env)
        env[:vm].config.vm.host_name += "." + env[:vm].config.vm.host_name;
      @app.call(env)
    end
  end
end
