if ENV['BEAKER'] == 'true'
  # running in BEAKER test environment
  require 'spec_helper_acceptance'
else
  # running in non BEAKER environment
  require 'serverspec'
  set :backend, :exec
end

describe 'profile_redis class' do

  context 'default parameters' do
    if ENV['BEAKER'] == 'true'
      # Using puppet_apply as a helper
      it 'should work idempotently with no errors' do
        pp = <<-EOS
        class { 'profile_redis': }
        EOS

        # Run it twice and test for idempotency
        apply_manifest(pp, :catch_failures => true)
        apply_manifest(pp, :catch_changes  => true)
      end
    end

    describe package('redis-server') do
      it { is_expected.to be_installed }
    end

    describe service('redis-server') do
      it { is_expected.to be_enabled }
      it { is_expected.to be_running }
    end

    describe port(6379) do
      it { should be_listening.with('tcp') }
    end

  end
end
