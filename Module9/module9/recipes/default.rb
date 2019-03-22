docker_service 'default' do
  insecure_registry 'localhost:5000'
  registry_mirror 'http://localhost:5000'
  action [:create, :start]
end

docker_image 'registry' do
  action :pull
end

docker_volume 'rg' do
  action :create
end

cookbook_file "/config.yml" do
  source "config.yml"
  mode "0644"
  end

docker_container 'registry' do
  repo 'registry'
  port '5000:5000'
  volumes [ 'rg:/var/lib/registry', '/config.yml:/etc/docker/registry/config.yml' ]
end