require 'spec_helper'

describe 'openconnect' do
  context 'supported operating systems' do
    ['Debian'].each do |osfamily|
      describe "openconnect class without any parameters on #{osfamily}" do
        let(:params) {{ }}
        let(:facts) {{
          :osfamily => osfamily,
        }}

        it { should include_class('openconnect::params') }

        it { should contain_class('openconnect::install') }
        it { should contain_class('openconnect::config') }
        it { should contain_class('openconnect::service') }
      end
    end
  end

  context 'unsupported operating system' do
    describe 'openconnect class without any parameters on CentOS/RedHat' do
      let(:facts) {{
        :osfamily        => 'RedHat',
        :operatingsystem => 'CentOS',
      }}

      it { expect { should }.to raise_error(Puppet::Error, /CentOS not supported/) }
    end
  end
end
