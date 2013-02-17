default[:geminabox] = Mash.new
default[:geminabox][:version] = '~> 0.6.0'
# app configs
default[:geminabox][:config_directory] = '/etc/geminabox'
default[:geminabox][:base_directory] = '/var/www/geminabox'
default[:geminabox][:data_directory] = 'data' # This values is joined to base_directory
default[:geminabox][:build_legacy] = false
# auth configs
default[:geminabox][:auth_required] = false
# sys configs
default[:geminabox][:www_user] = 'www-data'
default[:geminabox][:www_group] = 'www-data'
# ssl configs
default[:geminabox][:ssl][:enabled] = false
# unicorn configs
default[:geminabox][:unicorn] = Mash.new
default[:geminabox][:unicorn][:install] = false
default[:geminabox][:unicorn][:version] = '> 0'
default[:geminabox][:unicorn][:cow_friendly] = true
default[:geminabox][:unicorn][:timeout] = 30
default[:geminabox][:unicorn][:workers] = 2
default[:geminabox][:unicorn][:maxmemory] = 50
default[:geminabox][:unicorn][:maxcpu] = 20
default[:geminabox][:unicorn][:exec] = '/usr/local/bin/unicorn'
default[:geminabox][:unicorn][:config_dir] = '/etc/unicorn'

# nginx configs
default[:geminabox][:nginx] = Mash.new
default[:geminabox][:nginx][:port] = '80'

# bluepill configs
default[:geminabox][:bluepill] = Mash.new
