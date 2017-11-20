require 'spec_helper'

describe 'profile_nfs' do
  context 'supported operating systems' do
    on_supported_os.each do |os, facts|
      context "on #{os}" do
        let(:facts) do
          facts.merge({
            :db_export_net => "localhost",
            :concat_basedir => "/foo"
          })
        end

        context "profile_nfs class without any parameters" do
          let(:params) {{ }}

          it { is_expected.to compile.with_all_deps }
          it { is_expected.to contain_class('profile_nfs') }
          it { is_expected.to contain_class('profile_nfs::params') }

          it { is_expected.to contain_nfs__server__export('/mnt/nfs') }
          it { is_expected.to contain_nfs__server__export('/mnt/nfs/config') }
          it { is_expected.to contain_nfs__server__export('/mnt/nfs/errors') }
          it { is_expected.to contain_nfs__server__export('/mnt/nfs/logs') }
          it { is_expected.to contain_nfs__server__export('/mnt/nfs/office-templates') }

        end
      end
    end
  end
end
