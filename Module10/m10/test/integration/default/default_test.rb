describe service('docker') do
  it { should be_installed }
  it { should be_enabled }
  it { should be_running }
end

describe file('/etc/nginx_docker/') do
  it { should exist }
  it { should be_directory }
end

describe file('/etc/nginx_docker/green.conf') do
  it { should exist }
end

describe file('/etc/nginx_docker/blue.na') do
  it { should exist }
end

describe docker_container('nginx') do
  it { should exist }
  it { should be_running }
end

describe docker_container('registry') do
  it { should exist }
  it { should be_running }
end

describe docker_container('green_tom') do
  it { should exist }
  it { should be_running }
end