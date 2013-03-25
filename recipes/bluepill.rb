include_recipe "bluepill"

gem_package('red_unicorn') do
  action :install
end


template '/etc/init/geminabox.conf' do
  source 'upstart-geminabox-bluepill.erb'
  variables(
    :www_user => node[:geminabox][:www_user],
    :base_directory => node[:geminabox][:base_directory]
  )
  notifies :restart, 'service[geminabox]'
end

template '/etc/bluepill/geminabox.pill' do
  source 'bluepill-geminabox.pill.erb'
  variables(
    :pid => File.join(node[:geminabox][:base_directory], 'unicorn.pid'),
    :working_directory => node[:geminabox][:base_directory],
    :config => File.join(node[:geminabox][:thin][:config_dir], 'thin_config.yml'),
    :process_user => node[:geminabox][:www_user],
    :process_group => node[:geminabox][:www_group],
    :maxmemory => node[:geminabox][:thin][:maxmemory],
    :maxcpu => node[:geminabox][:thin][:maxcpu]
  )
  notifies :restart, 'service[geminabox]'
end



service 'geminabox' do
  provider Chef::Provider::Service::Upstart
  supports :status => true, :restart => true, :reload => true
  action [:enable, :start]
end
