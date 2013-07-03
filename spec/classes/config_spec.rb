require 'spec_helper'

# Tests ::openconnect::config proxy of ::openconnect
describe 'openconnect' do
  let(:upstart_file) { '/etc/init/openconnect.conf' }
  let(:passwd_file) { '/etc/openconnect/network.passwd' }
  let(:default_params) {{
    :url  => 'https://vpn.example.com/profile',
    :user => 'janesmith',
    :pass => 'mekmitasdigoat',
  }}
  let(:facts) {{
    :osfamily => 'Debian',
  }}

  describe 'mandatory params' do
    let(:params) {
      default_params
    }

    it 'should set url' do
      should contain_file(upstart_file).with_content(
        /^\s*https:\/\/vpn.example.com\/profile \\$/
      )
    end

    it 'should set user' do
      should contain_file(upstart_file).with_content(
        /^\s*--user janesmith \\$/
      )
    end

    it 'should set pass' do
      should contain_file(passwd_file).with_content('mekmitasdigoat')
    end

    it 'should not set dnsupdate' do
      should_not contain_file(upstart_file).with_content(/DNS_UPDATE/)
    end

    it 'should not set cacerts' do
      should_not contain_file(upstart_file).with_content(/--CAfile/)
    end
  end

  context 'dnsupdate true' do
    let(:params) { default_params.merge({
      :dnsupdate => false,
    })}

    it 'should set and export an env var' do
      should contain_file(upstart_file).with_content(
        /^env DNS_UPDATE=no\nexport DNS_UPDATE\n/
      )
    end
  end

  context 'cacerts string' do
    let(:pem_cert) { <<EOS
-----BEGIN CERTIFICATE-----
blah blah blah
-----END CERTIFICATE-----
EOS
    }
    let(:params) { default_params.merge({
      :cacerts => pem_cert,
    })}

    it 'should set and export an env var' do
      should contain_file(upstart_file).with_content(
        /^\s*--CAfile \/etc\/openconnect\/network\.cacerts \\$/
      )
    end

    it 'should write the certs to a file' do
      should contain_file('/etc/openconnect/network.cacerts').with_content(pem_cert)
    end
  end

  context 'validate params' do
    %w{url user pass cacerts}.each do |param|
      describe param do
        let(:params) { default_params.merge({
          param.to_sym => ['an', 'array'],
        })}

        it 'should reject an array' do
          expect { should }.to raise_error(Puppet::Error, /is not a string/)
        end
      end
    end

    %w{dnsupdate}.each do |param|
      describe param do
        let(:params) { default_params.merge({
          param.to_sym => 'true',
        })}

        it 'should reject a string' do
          expect { should }.to raise_error(Puppet::Error, /is not a boolean/)
        end
      end
    end
  end
end
