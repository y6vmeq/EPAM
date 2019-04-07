docker_service 'default' do
  daemon true
  insecure_registry 'localhost:5000'
  action [:create, :start]
end

docker_image 'registry' do
  action :pull
end

docker_image 'nginx' do
  action :pull
end

docker_image 'tomcat' do
  action :pull
end

docker_volume 'rg' do
  action :create
end

docker_container 'registry' do
  repo 'registry'
  port '5000:5000'
  volumes [ 'rg:/var/lib/registry' ]
end

directory '/etc/nginx_docker/' do
  action :create
  mode "0777"
end

cookbook_file "/etc/nginx_docker/green" do
  source "green"
  mode "0777"
end

cookbook_file "/etc/nginx_docker/blue" do
  source "blue"
  mode "0777"
end

docker_container 'nginx' do
  repo 'nginx'
  port '80:80'
end

docker_tag 'save_tom' do
  target_repo 'tomcat'
  target_tag 'latest'
  to_repo 'localhost:5000/tomcat'
  to_tag node['m10']['tag']
  action :tag
end

docker_tag 'save_tom' do
  target_repo 'tomcat'
  target_tag 'latest'
  to_repo 'localhost:5000/tomcat'
  to_tag '1.1.2'
  action :tag
end

execute 'push tomcats' do
  command 'sudo docker push localhost:5000/tomcat:1.1.1 && sudo docker push localhost:5000/tomcat:1.1.2'
end