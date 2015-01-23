#
# Cookbook Name:: runner_setup
# Recipe:: default
#
# Copyright 2015, YOUR_COMPANY_NAME
#
# All rights reserved - Do Not Redistribute
#

remote_file "/tmp/runner.deb" do
  source "https://s3-eu-west-1.amazonaws.com/downloads-packages/ubuntu-14.04/gitlab-runner_5.1.0~pre.omnibus.1-1_amd64.deb"
end

execute "sudo dpkg -i runner.deb" do
  cwd "/tmp"
end

execute "sudo useradd -s /bin/false -m -r gitlab-runner"

execute "sudo CI_SERVER_URL=#{node['runner']['ci-url']} REGISTRATION_TOKEN=#{node['runner']['token']} /opt/gitlab-runner/bin/setup -C /home/gitlab-runner"

execute "sudo cp /opt/gitlab-runner/doc/install/upstart/gitlab-runner.conf /etc/init/"

execute "sudo service gitlab-runner start"
