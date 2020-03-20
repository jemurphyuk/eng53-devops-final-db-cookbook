
# This is an example test, replace it with your own test.
describe port(27017) do
  it { should be_listening }
  its('addresses') { should include '0.0.0.0' }
end

describe service "mongod" do
  it { should be_running }
  it { should be_enabled }
end

describe package "mongodb-org" do
  it { should be_installed }
  its('version') { should cmp > '3.2.*' }
end
