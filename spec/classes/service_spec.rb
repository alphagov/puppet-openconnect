require 'spec_helper'

describe 'openconnect::service' do
  describe 'openconnect::service class on RedHat' do
    let(:facts) {{
      :osfamily => 'RedHat',
    }}

    it { should contain_service('foo') }
  end

  describe 'openconnect::service class on Debian' do
    let(:facts) {{
      :osfamily => 'Debian',
    }}

    it { should contain_service('foo') }
  end
end

