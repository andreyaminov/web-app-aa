package ['apache2', 'php', 'php-mysql'] do
  action :install
end

service 'apache2' do
  action [:enable, :start]
end

cookbook_file '/var/www/html/index.php' do
  source 'index.php'
  owner 'root'
  group 'root'
  mode '0755'
  action :create
end

cookbook_file '/var/www/html/index.html' do
  action :delete
end
