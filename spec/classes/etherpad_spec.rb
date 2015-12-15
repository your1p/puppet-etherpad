require 'spec_helper'

describe 'etherpad' do
  context 'supported operating systems' do
    on_supported_os.each do |os, facts|
      context "on #{os}" do
        let(:facts) do
          facts
        end

        context "etherpad class without any parameters" do
          it { is_expected.to compile.with_all_deps }

          it { is_expected.to contain_vcsrepo('/opt/etherpad') }
          it { is_expected.to contain_file('/opt/etherpad/settings.json') }
          it { is_expected.to contain_service('etherpad') }
        end
      end
    end
  end

  context 'supported operating systems' do
    on_supported_os.each do |os, facts|
      context "on #{os}" do
        let(:facts) do
          facts
        end

        context "etherpad class with all parameters set" do
          let(:params) do
            {
              :ensure           => 'present',
              :service_name     => 'etherpad',
              :service_ensure   => 'running',
              :service_provider => facts[:service_provider],
              :manage_user      => true,
              :manage_abiword   => false,
              :abiword_path     => '/usr/bin/abiword',
              :manage_tidy      => false,
              :tidy_path        => '/usr/bin/tidy',
              :user             => 'etherpad',
              :group            => 'etherpad',
              :root_dir         => '/opt/etherpad',
              :source           => 'https://github.com/ether/etherpad-lite.git',

              # Db
              :database_type     => 'dirty',
              :database_host     => 'localhost',
              :database_user     => 'etherpad',
              :database_name     => 'etherpad',
              :database_password => 'etherpad',

              # Network
              :ip          => '*',
              :port        => 9001,
              :trust_proxy => false,

              # Performance
              :max_age => 21600,
              :minify  => true,

              # Config
              :require_session        => false,
              :edit_only              => false,
              :require_authentication => false,
              :require_authorization  => false,
              :pad_title              => :undef,
              :default_pad_text       => 'Welcome to etherpad!',
            }
          end

          it { is_expected.to compile.with_all_deps }
        end
      end
    end
  end
end
