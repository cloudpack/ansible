# 使い方
UserDataに以下のコードを挿入し実行してください。
CFn内のUserDataでも可です。

## UserData Version
    #!/bin/sh
    yum update -y
    yum install epel-release -y
    yum install ansible --enablerepo=epel -y
    # yum install gcc python-devel python-crypto python-pip git -y
    # easy_install pip
    # pip install ansible
    cd ~
    git clone https://github.com/cloudpack/ansible.git

    cat <<EOF > ansible/group_vars/all.yml
    datadog: true
    DD_API_KEY: xxxxxxxxxxxxxxxx
    EOF
    ansible-playbook ansible/xxx.yml

    # sshdを有効にしたい場合
    # ansible-playbook ansible/xxx.yml -e "sshd=enable"

## CloudFormation Version (HereDocument Only)
    "cat <<EOF > ansible/group_vars/all.yml\n",
    "datadog: ",
    { "Ref": "datadog" },
    "\n",
    "DD_API_KEY: ",
    { "Ref": "DD_API_KEY" },
    "\n",
    "EOF\n",

# 必要なIAMロール権限
- AmazonEC2RoleforSSM
- CloudWatchLogsFullAccess

# ルール
## 各Role追加時には以下を考慮し追加してください
- ログファイルが出力される場合
-- logrotateのconfファイルを配置する
-- CloudWatch Logs Agentのconfファイルを配置する
- DatadogのIntegrationがある場合
-- Datadogのyamlの配置する
- プロセスがある場合
-- monitのconfを配置する
