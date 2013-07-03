require 'spec_helper'

describe 'openconnect' do
  context 'supported operating systems' do
    ['Debian'].each do |osfamily|
      describe "osfamily is #{osfamily}" do
        let(:facts) {{
          :osfamily => osfamily,
        }}

        describe 'with mandatory params' do
          let(:params) {{
            :url  => 'https://vpn.example.com/profile',
            :user => 'janesmith',
            :pass => 'mekmitasdigoat',
          }}

          it { should include_class('openconnect::params') }

          it { should contain_class('openconnect::install') }
          it { should contain_class('openconnect::config') }
          it { should contain_class('openconnect::service') }
        end

        describe 'without any params' do
          let(:params) {{ }}
          it 'should require mandatory params' do
            expect { should }.to raise_error(Puppet::Error, /Must pass/)
          end
        end
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
