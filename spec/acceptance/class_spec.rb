if ENV['BEAKER'] == 'true'
  # running in BEAKER test environment
  require 'spec_helper_acceptance'
else
  # running in non BEAKER environment
  require 'serverspec'
  set :backend, :exec
end

describe 'profile_nfs class' do

  context 'default parameters' do
    if ENV['BEAKER'] == 'true'
      # Using puppet_apply as a helper
      it 'should work idempotently with no errors' do
        pp = <<-EOS
        class { 'profile_nfs': }
        EOS

        # Run it twice and test for idempotency
        apply_manifest(pp, :catch_failures => true)
        apply_manifest(pp, :catch_changes  => true)
      end
    end

    describe package('nfs-kernel-server') do
      it { is_expected.to be_installed }
    end

    describe service('nfs-kernel-server') do
      it { is_expected.to be_enabled }
      it { is_expected.to be_running }
    end

    describe port(2049) do
      it { should be_listening.with('tcp') }
      it { should be_listening.with('udp') }
    end

    describe port(111) do
      it { should be_listening.with('tcp') }
      it { should be_listening.with('udp') }
    end

    describe file('/mnt/nfs') do
      it { should be_directory }
    end

    describe file('/mnt/nfs/office-templates') do
      it { should be_directory }
    end

    describe file('/mnt/nfs/config') do
      it { should be_directory }
    end

    describe file('/mnt/nfs/errors') do
      it { should be_directory }
    end

    describe file('/mnt/nfs/logs') do
      it { should be_directory }
    end

  end
end
