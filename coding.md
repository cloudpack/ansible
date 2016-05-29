# ファイルの配置
- copyを使う
- files配下にフルパスで配置する
- ext) files/etc/httpd/conf/httpd.conf
- コピーする際にファイル名を指定せずにディレクトリを指定する

## files
- files直下はOSもしくはVersionのディレクトリを配置する
- その配下に/ディレクトリ以降のファイルパスを配置する
- OS/Versionに依存しないものはcommonディレクトリに配置する
~~~
.
├── centos6
│   └── etc
│       ├── logrotate.d
│       │   └── httpd
│       └── monit.d
│           └── httpd
├── centos7
│   └── etc
│       ├── logrotate.d
│       │   └── httpd
│       └── monit.d
│           └── httpd
├── common
│   └── etc
│       ├── dd-agent
│       │   └── conf.d
│       │       └── apache.yaml
│       └── httpd
│           └── conf.d
│               ├── autoindex.conf
│               └── welcome.conf
├── ver2.2
│   └── etc
│       └── httpd
│           └── conf
│               └── httpd.conf
└── ver2.4
    └── etc
        ├── httpd
        │   └── conf
        │       └── httpd.conf
        ├── logrotate.d
        │   └── httpd
        └── monit.d
~~~
- コピーする際にファイル名を指定せずにディレクトリを指定する
~~~
  copy: src=ver2.4/etc/httpd/ dest=/etc/httpd/ owner=root group=root mode=0644
~~~
