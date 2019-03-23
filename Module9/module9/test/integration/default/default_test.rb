describe service('docker') do
  it { should be_installed }
  it { should be_enabled }
  it { should be_running }
end

describe file("/config.yml") do
  it { should exist } 
end

describe docker_container('registry') do
  it { should exist }
  it { should be_running }
end
