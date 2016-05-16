require 'spec_helper'

describe package('epel-release') do
  it { should be_installed }
end

describe yumrepo('epel') do
  it { should exist }
end

%w{
  dstat
  sysstat
  iotop
  mlocate
  telnet
  htop
  strace
  monit
  vim-enhanced
  wget
  tree
  postfix
  unzip
  make
  gcc
  gcc-c++
  screen
}.each do |pkg|
  describe package(pkg) do
    it { should be_installed }
  end
end

%w{ awscli boto3 }.each do |pkg|
  describe package(pkg) do
    it { should be_installed.by('pip') }
  end
end

describe service('awslogs') do
  it { should be_enabled }
  it { should be_running }
end

if os[:family] == 'amazon'
  describe package('awslogs') do
    it { should be_installed }
  end
  awslogs_conf = '/etc/awslogs/awslogs.conf'
  awscli_conf = '/etc/awslogs/awscli.conf'
elsif os[:family] == 'redhat'
  awslogs_conf = '/var/awslogs/etc/awslogs.conf'
  awscli_conf = '/var/awslogs/etc/aws.conf'
end

describe file(awslogs_conf) do
  its(:content) { should match /^\[general\]$/ }
  its(:content) { should match /^\[\/var\/log\/messages\]$/ }
  its(:content) { should match /^\[\/var\/log\/cron\]$/ }
  its(:content) { should match /^\[\/var\/log\/maillog\]$/ }
  its(:content) { should match /^\[\/var\/log\/secure\]$/ }
  its(:content) { should match /^\[\/var\/log\/yum\.log\]$/ }
  its(:content) { should match /^\[\/var\/log\/cloud-init\.log\]$/ }
  its(:content) { should match /^\[\/var\/log\/amazon\/ssm\/amazon-ssm-agent\.log\]$/ }
  its(:content) { should match /^\[\/var\/log\/awslogs\.log\]$/ }
end

describe file(awscli_conf) do
  its(:content) { should match /^region = ap-northeast-1$/ }
end

describe package('amazon-ssm-agent') do
  it { should be_installed }
end

describe package('codedeploy-agent') do
  it { should be_installed }
end

describe service('codedeploy-agent') do
  it { should be_enabled }
  it { should be_running }
end

describe file('/etc/localtime') do
  it { should be_linked_to '/usr/share/zoneinfo/Asia/Tokyo' }
end

describe service('rsyslog') do
  it { should be_enabled }
  it { should be_running }
end

describe file('/etc/profile.d/motd.sh') do
  it { should be_mode 755 }
  its(:content) { should match /Instance ID:/ }
end

describe file('/etc/profile.d/motd.sh') do
  it { should be_mode 755 }
  its(:content) { should match /Instance ID:/ }
  it { should be_owned_by 'root' }
  it { should be_grouped_into 'root' }
end

describe file('/etc/bashrc') do
  its(:content) { should match /^HISTSIZE=10000$/ }
  its(:content) { should match /^HISTTIMEFORMAT=\'%Y\/%m\/%d %H:%M:%S '$/ }
end

describe file('/swapfile') do
  it { should be_mode 600 }
end

describe file('/etc/fstab') do
  its(:content) { should match /\/swapfile swap swap defaults 0 0/ }
end

describe file('/etc/locale.conf'), :if => os[:family] == 'redhat' do
  its(:content) { should match /LANG=ja_JP\.UTF-8/ }
end
