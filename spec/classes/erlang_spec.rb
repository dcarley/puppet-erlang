require 'spec_helper'

describe 'erlang' do
  describe 'when osfamily is RedHat' do
    let(:facts) {{
      :osfamily => 'RedHat',
    }}
    # Mock EPEL class for include.
    let :pre_condition do
      'class epel {}'
    end

    it { should include_class('epel') }
    it { should contain_package('erlang').with(
      :name     => 'erlang',
      :ensure   => 'present',
      :require  => 'Class[Epel]'
    )}
  end

  describe 'when osfamily is Debian' do
    let(:facts) {{
      :osfamily => 'Debian',
    }}

    it { should contain_package('erlang').with(
      :name     => 'erlang-nox',
      :ensure   => 'present',
      :require  => nil,
    )}

    describe 'when parameters are supplied' do
      let(:params) {{
        :package_ensure   => 'latest',
        :package_name     => 'erlang-base',
        :package_require  => 'Class[Foo]',
      }}
      it { should contain_package('erlang').with(
        :name     => 'erlang-base',
        :ensure   => 'latest',
        :require  => 'Class[Foo]'
      )}
    end
  end

  describe 'when operatingsystem is Debian' do
    let(:facts) {{
      :osfamily         => nil,
      :operatingsystem  => 'Debian',
    }}

    it { should contain_package('erlang').with(
      :name     => 'erlang-nox',
      :ensure   => 'present',
      :require  => nil,
    )}
  end

  describe 'when osfamily and operatingsystem are unsupported' do
    let(:facts) {{
      :osfamily         => 'foo',
      :operatingsystem  => 'bar',
    }}

    it { expect{ subject }.to raise_error(
      /^Module \S+ does not support bar/
    )}
  end
end
