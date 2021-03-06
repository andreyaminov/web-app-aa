#
# Cookbook Name:: web-app-aa
# Recipe:: apache
#
#

# Get Package Attributes defined in REAN
db_host = node['web-app-aa']['db_host']
db_user = node['web-app-aa']['db_user']
db_pwd = node['web-app-aa']['db_pwd']
db_name = node['web-app-aa']['db_name']

# install apache2, php, php-mysql packages
package ['apache2', 'php', 'php-mysql'] do
  action :install
end

# start apache2 at startup
service 'apache2' do
  action [:enable, :start]
end

# build /var/www/html/index.php file from the template
# /templates/index.php.erb using package attributes defined in REAN
template '/var/www/html/index.php' do
  source 'index.php.erb'
  variables({
    :srv	=> db_host,
	:user	=> db_user,
	:pwd	=> db_pwd,
	:db		=> db_name
  })
  owner 'root'
  group 'root'
  mode '0755'
end

# 
# copy index.php from files/ to /var/www/html/index.php
# without any modification
#
# cookbook_file '/var/www/html/index.php' do
#   source 'index.php'
#   owner 'root'
#   group 'root'
#   mode '0755'
#   action :create
# end

cookbook_file '/var/www/html/index.html' do
  action :delete
end
