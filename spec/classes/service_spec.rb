require 'spec_helper'

describe 'openconnect::service' do
  describe 'openconnect::service class on Debian' do
    let(:facts) {{
      :osfamily => 'Debian',
    }}

    it { should contain_service('openconnect') }
  end
end

