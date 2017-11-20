require 'spec_helper'

describe 'profile_redis' do
  context 'supported operating systems' do
    on_supported_os.each do |os, facts|
      context "on #{os}" do
        let(:facts) do
          facts.merge({
            :concat_basedir => "/foo",
          })
        end

        context "profile_redis class without any parameters" do
          let(:params) {{ }}

          it { is_expected.to compile.with_all_deps }
          it { is_expected.to contain_class('profile_redis') }
          it { is_expected.to contain_class('profile_redis::params') }
          it { is_expected.to contain_class('profile_redis::install') }
          it { is_expected.to contain_class('profile_redis::config') }
          it { is_expected.to contain_class('profile_redis::service') }

          it { is_expected.to contain_package('redis-server') }

          it { is_expected.to contain_File_line('change_bindaddress') }

          it { is_expected.to contain_service('redis-server') }
        end
      end
    end
  end
end
