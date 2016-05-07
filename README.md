# 使い方
UserDataに以下のコードを挿入し実行してください。
CFn内のUserDataでも可です。

## UserData Version
    #!/bin/sh
    yum update -y
    yum install epel-release -y
    yum install gcc python-devel python-crypto python-pip git -y
    easy_install pip
    pip install ansible
    cd ~
    git clone https://github.com/cloudpack/ansible.git

    cat <<EOF > ansible/group_vars/all.yml
    datadog: true
    DD_API_KEY: xxxxxxxxxxxxxxxx
    EOF
    ansible-playbook ansible/xxx.yml

## CloudFormation Version (HereDocumetn Only)
    "cat <<EOF > ansible/group_vars/all.yml\n",
    "datadog: ",
    { "Ref": "datadog" },
    "\n",
    "DD_API_KEY: ",
    { "Ref": "DD_API_KEY" },
    "\n",
    "EOF\n",

# ルール
## 各Role内は以下を含めて下さい
### ログファイルが出力される場合
logrotateのconfファイルを配置し、ローテーションを実行
### CloudWatchLogsにログの転送が必要場合（ログファイルを外出ししたい場合）
CloudWatch Logs Agentのconfファイル 
### Datadogで個別メトリクスを収集したい場合
必要に応じてDatadogのyamlの配置＋yamlの書き換え
