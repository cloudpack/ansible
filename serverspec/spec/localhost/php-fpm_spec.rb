require 'spec_helper'

%w{
  php
  php-fpm
  php-mcrypt
  php-cli
  php-common
  php-devel
  php-mbstring
  php-mysqlnd
  php-opcache
  php-pdo
  php-pear
  php-pecl-apcu
  php-process
  php-xml
  php-gd
}.each do |pkg|
  describe package(pkg) do
    it { should be_installed }
  end
end

describe file('/etc/php-fpm.d/www.conf') do
  its(:content) { should match /^listen = \/var\/run\/php-fpm\/php-fpm.sock$/ }
end

describe service('php-fpm') do
  it { should be_enabled }
  it { should be_running }
end

describe file('/etc/nginx/default.d/php-fpm.conf') do
  its(:content) { should match /^\s+fastcgi_pass   unix:\/var\/run\/php-fpm\/php-fpm\.sock;$/ }
end

describe file('/etc/awslogs/config/php-fpm.conf'), :if => os[:family] == 'amazon' do
  its(:content) { should match /^\[\/var\/log\/php-fpm\/error.log\]$/ }
end

describe file('/var/awslogs/etc/config/php-fpm.conf'), :if => os[:family] == 'redhat' do
  its(:content) { should match /^\[\/var\/log\/php-fpm\/error.log\]$/ }
end

describe file('/etc/logrotate.d/php-fpm') do
  its(:content) { should match /^\s+rotate 7$/ }
end