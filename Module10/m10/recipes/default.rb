docker_image 'localhost:5000/tomcat' do
  tag node['m10']['tag']
  action :pull_if_missing
end

frst = docker_container 'blue_tom' do
  repo 'localhost:5000/tomcat'
  tag node['m10']['tag']
  port '8080:8080'
  only_if "nmap -p 8080 localhost | grep closed"
  only_if "nmap -p 8081 localhost | grep closed"
end

ruby_block "Change container" do
  block do
    ::File.rename("/etc/nginx_docker/blue","/etc/nginx_docker/blue.conf")
  end
  only_if { frst.updated_by_last_action? }
end

docker_container 'nginx' do
  action :reload
  only_if { frst.updated_by_last_action? }
end

chk_green = docker_container 'green_tom' do
  repo 'localhost:5000/tomcat'
  tag node['m10']['tag']
  port '8081:8080'
  only_if "nmap -p 8080 localhost | grep open"
  not_if { frst.updated_by_last_action? }
end

ruby_block "Change container" do
  block do
    ::File.rename("/etc/nginx_docker/green","/etc/nginx_docker/green.conf")
    ::File.rename("/etc/nginx_docker/blue.conf","/etc/nginx_docker/blue")
  end
  only_if { chk_green.updated_by_last_action? }
end

docker_container 'nginx' do
  action :reload
  only_if { chk_green.updated_by_last_action? }
end

docker_container 'blue_tom' do
  action :delete
  only_if { chk_green.updated_by_last_action? }
end


chk_blue = docker_container 'blue_tom' do
  repo 'localhost:5000/tomcat'
  tag node['m10']['tag']
  port '8080:8080'
  only_if "nmap -p 8081 localhost | grep open"
  not_if { chk_green.updated_by_last_action? }
end

ruby_block "Change container" do
  block do
    ::File.rename("/etc/nginx_docker/green.conf","/etc/nginx_docker/green")
    ::File.rename("/etc/nginx_docker/blue","/etc/nginx_docker/blue.conf")
  end
  only_if { chk_blue.updated_by_last_action? }
end

docker_container 'nginx' do
  action :reload
  only_if { chk_blue.updated_by_last_action? }
end

docker_container 'green_tom' do
  action :delete
  only_if { chk_blue.updated_by_last_action? }
end