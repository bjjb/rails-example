server "example.bjjb.org", :web, :app, :db, primary: true

set :application, "rails-example"
set :user, "deployer"
set :deploy_to, "/srv/example.bjjb.org"
set :deploy_via, :remote_cache

set :scm, :git
set :repository,  "git@github.com:jjbuckley/rails-example.git"
set :branch, "master"

default_run_options[:pty] = true
ssh_options[:forward_agent] = true

set :use_sudo, false

after "deploy:restart", "deploy:cleanup"

namespace :deploy do
  %w(start stop restart).each do |command|
    desc "#{command} unicorn server"
    task command, roles: :app, except: { no_release: true } do
      run "/etc/init.d/unicorn_#{application} #{command}"
    end
  end
end
