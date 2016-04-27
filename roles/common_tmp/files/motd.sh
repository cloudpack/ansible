# Place to /etc/profile.d/
echo "####"
echo -e "#### You have logged in to \e[1m$HOSTNAME\e[m as \e[1m$USER\e[m successfully."
echo -e "#### This server is running on \e[1m\e[33mAWS\e[m."
echo "####   Instance ID:       `curl -s 169.254.169.254/latest/meta-data/instance-id`"
echo "####   Instance Type:     `curl -s 169.254.169.254/latest/meta-data/instance-type`"
echo "####   Availability Zone: `curl -s 169.254.169.254/latest/meta-data/placement/availability-zone`"
echo "####   Private IP:        `curl -s 169.254.169.254/latest/meta-data/local-ipv4`"
public_ip=`curl -s 169.254.169.254/latest/meta-data/public-ipv4 | head -n 1 | grep -e "^[^<]"`
echo "####   Public IP:         $public_ip"
echo "####"
echo

if [ `rpm -qa |grep "ds_agent"` ]; then
  echo "------------------------------------------------------------------------------------"
  echo -e " \e[1m\e[33m このホストには変更監視が入っています。事前に申請の上で変更作業を行ってください。 \e[m"
  echo "------------------------------------------------------------------------------------"
fi
