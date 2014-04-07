require 'spec_helper'

describe 'openconnect::service' do
  describe 'openconnect::service class on Debian' do
    let(:facts) {{
      :osfamily => 'Debian',
    }}

    it 'should manage service' do
      should contain_service('openconnect').with({
        :ensure => 'running',
        :enable => 'true',
      })
    end

    it 'should stop+start to pick up changes' do
      should contain_service('openconnect').with({
        :hasrestart => false,
      })
    end
  end
end

