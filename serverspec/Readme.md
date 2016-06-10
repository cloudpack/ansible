# serverspec実行手順

### 事前準備

    yum install -y ruby ruby-devel;gem install io-console bundler --no-rdoc --no-ri;cd ansible;bundle

### 実行

##### すべて実行

    rake spec

##### 指定したファイルのみ実行

    rspec spec/localhost/common_spec.rb
