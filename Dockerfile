FROM alpine:latest

MAINTAINER Charles Gunzelman
LABEL org.label-schema.docker.dockerfile="/Dockerfile" \
      org.label-schema.vcs-type="Git" \
      org.label-schema.vcs-url="https://github.com/packetworks/docker-nxfilter"

ENV container docker

COPY /root entrypoint.sh url.txt /

#RUN apt -y update \ 
#  && apt -y upgrade \
#  && apt -y install wget unzip default-jre libtcnative-1 libapr1 libapr1-dev \
#  && apt -y clean autoclean \
#  && apt -y autoremove \
#  && rm -rf /var/lib/apt && rm -rf /var/lib/dpkg && rm -rf /var/lib/cache && rm -rf /var/lib/log

RUN apk update \
  && apk add openjdk8-jre tomcat-native apr curl bash \
  && rm -f /var/cache/apk/* \
  && xargs </url.txt curl -o nxfilter.zip -s \
  && mkdir /nxfilter \
  && unzip nxfilter.zip -d /nxfilter \
  && chmod +x /nxfilter/bin/startup.sh \
  && rm -f nxfilter.zip

ENTRYPOINT ["/entrypoint.sh"]

CMD ["/nxfilter/bin/startup.sh"]


#RUN curl -s -L http://www.nxfilter.org/|grep Download |grep -Eo "(http|https)://[a-zA-Z0-9./?=_-]*" |grep download|uniq |xargs -n1 curl -s -L |grep -Eo "(http|https)://[a-zA-Z0-9./?=_-]*" |grep filter-.*zip|grep -v mediafire |xargs -n1 wget -q && mkdir -p /nxfilter && unzip -o nxfil* -d /nxfilter && cp -R /nxfilter/conf /nxfilter/conf-default && chmod +x /nxfilter/bin/startup.sh && rm -f *.zip
##RUN echo "http://www.nxfilter.org/"$(curl -sL nxfilter.org/download.php|grep zip|grep nxfilter|head -n1|sed -e 's/<a .*href=['"'"'"]//' -e 's/["'"'"'].*$//'  -e '/^$/ d'|tr -d '[:blank:]') > url
#RUN wget -q --convert-links http://www.nxfilter.org/download.php ; cat download.php | sed -e 's/<a .*href=['"'"'"]//' -e 's/["'"'"'].*$//' -e '/^$/ d'|tr - d '[:blank:]'|grep zip|grep /nxfilter| head -n1 > url
#RUN wget -r --no-parent -A 'nxfilter*.zip' http://www.nxfilter.org/download.php
#RUN curl -s -L http://www.nxfilter.org/|grep Download|sed -e 's/<a /\n<a /g'|sed -e 's/<a .*href=['"'"'"]//' -e 's/["'"'"'].*$//' -e '/^$/ d'|xargs -n1 curl -s -L|grep zip|sed -e 's/<a /\n<a /g'|sed -e 's/<a .*href=['"'"'"]//' -e 's/["'"'"'].*$//' -e '/^$/ d'|grep -v dropbox|grep -v logon|grep -v cloud|grep zip \
#RUN wget --spider --force-html -r -l1 http://www.nxfilter.org/download.php 2>&1 | grep '^--' | awk '{ print $3 }'| grep 'nxfilter-' | grep 'zip'| grep -v 'cloud' | head -n1 > url.txt && wget -i url.txt
#CMD /nxfilter/bin/startup.sh

#RUN wget --output-document=nxfilter.zip http://pub.nxfilter.org/nxfilter-`curl http://www.nxfilter.org/curver.php`.zip'"
#RUN curl http://www.nxfilter.org/curver.php > version \
#  && awk '{print  "http://pub.nxfilter.org/nxfilter-"$0".zip}' version > url.txt \
#RUN echo "http://pub.nxfilter.org/nxfilter-" > url.txt \
#  && curl http://www.nxfilter.org/curver.php >> url.txt \
#  && echo .zip >> url.txt \
#  && tr -d '\n' < url.txt > url \
#  && wget -i url.txt -O nxfilter.zip
