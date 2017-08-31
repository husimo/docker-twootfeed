#!/bin/bash
echo API initialization
cat <<EOF > /rootfs/initialize.py
from mastodon import Mastodon

# Register app - only once!
Mastodon.create_app(
     'pytooterapp',
      api_base_url = '$API_BASE_URL',
      to_file = '/python-twootfeed/tootrss_clientcred.txt'
)

# Log in - either every time, or use persisted
mastodon = Mastodon(
    client_id = '/python-twootfeed/tootrss_clientcred.txt',
    api_base_url = '$API_BASE_URL')
mastodon.log_in(
    '$EMAIL',
    '$PASSWORD',
    to_file = '/python-twootfeed/tootrss_usercred.txt'
)
EOF
python /rootfs/initialize.py
cp /python-twootfeed/config.example.yml /python-twootfeed/config.yml
echo Start twootfeed
cd /python-twootfeed
export FLASK_APP=app.py
python3 -m flask run --host=0.0.0.0
