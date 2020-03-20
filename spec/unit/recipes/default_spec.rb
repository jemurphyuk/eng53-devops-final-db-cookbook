#
# Cookbook:: db_cookbook
# Spec:: default
#
# Copyright:: 2020, The Authors, All Rights Reserved.

require 'spec_helper'

describe 'db_cookbook::default' do
  context 'When all attributes are default, on Ubuntu 18.04' do
    # for a complete list of available platforms and versions see:
    # https://github.com/chefspec/fauxhai/blob/master/PLATFORMS.md
    platform 'ubuntu', '16.04'

    it 'converges successfully' do
      expect { chef_run }.to_not raise_error
    end

    it 'should apt_update' do
      expect(chef_run).to update_apt_update 'update_sources'
    end

    it 'should install mongodb' do
      expect(chef_run).to install_package "mongodb-org"
    end

    it 'enables mongodb' do
      expect(chef_run).to enable_service 'mongod'
    end

    it 'start mongodb' do
      expect(chef_run).to start_service 'mongod'
    end

    it "should create mongod.conf" do
      expect(chef_run).to create_template('/etc/mongod.conf')
    end

    it "should create mongod.service file" do
      expect(chef_run).to create_template('/lib/systemd/system/mongod.service')
    end
  end
end
