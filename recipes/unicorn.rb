if(node[:geminabox][:unicorn][:install])
  gem_package 'unicorn' do
    action :install
    version node[:geminabox][:unicorn][:version] || '> 0'
  end
end

node.default[:unicorn][:preload_app] = true
node.default[:unicorn][:worker_processes] = [node[:cpu][:total].to_i * 4, 8].min
node.default[:unicorn][:preload_app] = false
node.default[:unicorn][:before_fork] = 'sleep 1'
node.default[:unicorn][:port]  = "\"unix:/#{File.join(node[:geminabox][:base_directory], 'unicorn.socket')}\""
node.default[:unicorn][:options] = { :tcp_nodelay => true, :backlog => 100 }

unicorn_config 'geminabox.unicorn.app' do
  # File.join(node[:geminabox][:config_directory], 'geminabox.unicorn.app')
  # config_directory node[:geminabox][:unicorn][:config_directory]
  listen node[:unicorn][:port] => node[:unicorn][:options]
  worker_processes node[:geminabox][:unicorn][:workers] || 2
  worker_timeout node[:geminabox][:unicorn][:timeout] || 30
  working_directory node[:geminabox][:base_directory]
  log_dir  node[:geminabox][:log_dir]
  preload_app true
  owner node[:geminabox][:www_user] || 'www-data'
  group node[:geminabox][:www_group] || 'www-data'
  mode '0644'
  notifies :restart, 'service[geminabox]'
end

