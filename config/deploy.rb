require 'capistrano/setup'

# config valid only for current version of Capistrano
lock '3.5.0'

set :application, 'bitcoinlottery'
set :repo_url, 'git@github.com:Westerdals/PG4300-16-6-Bitcoin-Lottery.git'
set :scm, :git
set :branch, "test"
set :use_sudo, false
set :rails_env, "production"
set :deploy_via, :copy
set :keep_releases, 5
set :pty, true
set :tmp_dir, "#{fetch(:home)}/tmp"
set :normalize_asset_timestamps, false
set :ssh_options, { user: 'deployer', forward_agent: false }
server 'bitcoinlottery.immortaltools.com'

# Default branch is :master
# ask :branch, `git rev-parse --abbrev-ref HEAD`.chomp

# Default deploy_to directory is /var/www/my_app_name
# set :deploy_to, '/var/www/my_app_name'

# Default value for :scm is :git
# set :scm, :git

# Default value for :format is :airbrussh.
# set :format, :airbrussh

# You can configure the Airbrussh format using :format_options.
# These are the defaults.
# set :format_options, command_output: true, log_file: 'log/capistrano.log', color: :auto, truncate: :auto

# Default value for :pty is false
# set :pty, true

# Default value for :linked_files is []
# set :linked_files, fetch(:linked_files, []).push('config/database.yml', 'config/secrets.yml')

# Default value for linked_dirs is []
# set :linked_dirs, fetch(:linked_dirs, []).push('log', 'tmp/pids', 'tmp/cache', 'tmp/sockets', 'public/system')

# Default value for default_env is {}
# set :default_env, { path: "/opt/ruby/bin:$PATH" }

# Default value for keep_releases is 5
# set :keep_releases, 5

namespace :deploy do

  after :restart, :clear_cache do
    on roles(:web), in: :groups, limit: 3, wait: 10 do
      # Here we can do anything such as:
      # within release_path do
      #   execute :rake, 'cache:clear'
      # end
    end
  end

end
