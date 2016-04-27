    ### Apache
    # cat <<EOF > ansible/roles/apache/vars/main.yml
    # site:
    #  - { domain: "www.test1.com", owner: "root" }
    #  - { domain: "www.test2.co.jp", owner: "apache" }
    # EOF
    # ansible-playbook ansible/apache.yml
