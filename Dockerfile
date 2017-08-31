FROM python:3.6-alpine
RUN apk add --no-cache git bash
RUN mkdir /rootfs
RUN pip3 install flask bs4 feedgenerator tweepy pytz Mastodon.py PyYAML
RUN git clone https://github.com/SamR1/python-twootfeed.git
ADD ./start.sh /rootfs/start.sh
RUN chmod +x /rootfs/start.sh
CMD /bin/bash /rootfs/start.sh
