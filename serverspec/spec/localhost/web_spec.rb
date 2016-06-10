describe package('nginx') do
  it { should be_installed }
end

describe service('nginx') do
  it { should be_enabled }
  it { should be_running }
end

describe file('/etc/nginx/nginx.conf') do
  its(:content) { should_not match /proxy_pass/ }
end

describe file('/etc/nginx/conf.d/default.conf') do
  its(:content) { should match /real_ip_header  X-Forwarded-For;/ }
end

describe file('/usr/share/nginx/html/healthcheck') do
  its(:content) { should match /^healthcheck$/ }
end

describe file('/etc/logrotate.d/nginx') do
  its(:content) { should match /^\s+rotate 7$/ }
end

describe port(80) do
  it { should be_listening }
end

describe command('curl http://127.0.0.1/ -o /dev/null -w "%{http_code}\n" -s') do
  its(:stdout) { should match /^(200|403)$/ }
end

