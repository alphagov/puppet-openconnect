require 'spec_helper'

describe 'openconnect' do
  context 'supported operating systems' do
    ['Debian', 'RedHat'].each do |osfamily|
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

          it { should contain_class('openconnect::params') }

          it { should contain_class('openconnect::install') }
          it { should contain_class('openconnect::config') }
          it { should contain_class('openconnect::service') }
        end

        describe 'without any params' do
          let(:params) {{ }}
          it 'should require mandatory params' do
            is_expected.to compile.and_raise_error(/Must pass/)
          end
        end
      end
    end
  end

  context 'RedHat osfamily system' do
    describe 'osfamily is RedHat' do
      let(:facts) {{
        :osfamily => 'RedHat',
      }}

      let(:params) {{
        :url  => 'https://vpn.example.com/profile',
        :user => 'janesmith',
        :pass => 'mekmitasdigoat',
      }}

      it { should contain_file('/etc/init.d/openconnect') }
    end
  end

  context 'authgroup provided' do
    describe 'should be in the command line' do
      let(:facts) {{
        :osfamily => 'RedHat',
      }}

      let(:params) {{
        :url       => 'https://vpn.example.com/profile',
        :user      => 'janesmith',
        :pass      => 'mekmitasdigoat',
        :authgroup => 'testgroup',
      }}

      it { should contain_file('/etc/init.d/openconnect').with_content(/--authgroup=testgroup/) }

    end
  end

  context 'unsupported operating system' do
    describe 'openconnect class without any parameters on Darwin/Darwin' do
      let(:facts) {{
        :osfamily        => 'Darwin',
        :operatingsystem => 'Darwin',
      }}

      it { is_expected.to compile.and_raise_error(/Darwin not supported/) }
    end
  end
end
