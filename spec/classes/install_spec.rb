require 'spec_helper'

describe 'openconnect::install' do
  describe 'openconnect::install class on Debian' do
    let(:facts) {{
      :osfamily => 'Debian',
    }}

    it { should contain_package('vpnc') }
    it { should contain_package('openconnect') }
  end
end
