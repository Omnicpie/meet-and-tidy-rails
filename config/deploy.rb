# config valid for current version and patch releases of Capistrano
lock "~> 3.15.0"

set :application, "meet_and_tidy"
set :repo_url, "git@github.com:commitdigital/meet-and-tidy-rails.git"

# Default branch is :master
# ask :branch, `git rev-parse --abbrev-ref HEAD`.chomp
set :branch, ENV["BRANCH"] || "main"

# Default deploy_to directory is /var/www/my_app_name
# set :deploy_to, "/var/www/my_app_name"

set :deploy_via, :remote_cache
set :ssh_options, forward_agent: true

# Default value for :format is :airbrussh.
# set :format, :airbrussh

# You can configure the Airbrussh format using :format_options.
# These are the defaults.
# set :format_options, command_output: true, log_file: "log/capistrano.log", color: :auto, truncate: :auto

# Default value for :pty is false
# set :pty, true

set :puma_init_active_record, true

# Default value for :linked_files is []
append :linked_files, "config/master.key"

# Default value for linked_dirs is []
append :linked_dirs, "log", "node_modules", "public/packs", "storage", "tmp/cache", "tmp/pids", "tmp/sockets"

# Default value for default_env is {}
# set :default_env, { path: "/opt/ruby/bin:$PATH" }

# Default value for local_user is ENV['USER']
# set :local_user, -> { `git config user.name`.chomp }

# Default value for keep_releases is 5
# set :keep_releases, 5

# Uncomment the following to require manually verifying the host key before first deploy.
# set :ssh_options, verify_host_key: :secure

namespace :deploy do
  task :restart_sidekiq do
    on roles(:all) do
      execute :sudo, :systemctl, "restart", "sidekiq"
    end
  end
end

after "deploy", "deploy:restart_sidekiq"
