FROM 1science/java:oracle-jre-8

MAINTAINER Charles Gunzelman "cgunzelman@gmail.com"

# Download nxfilter
RUN curl -s -L http://www.nxfilter.org/|grep Download \
  |grep -Eo "(http|https)://[a-zA-Z0-9./?=_-]*"|grep download|uniq \
  |xargs -n1 curl -s -L|grep -Eo "(http|https)://[a-zA-Z0-9./?=_-]*" \
  |grep filter-.*zip|grep -v mediafire|xargs -n1 wget -q

RUN mkdir /nxfilter \
  && unzip nxfil* -d /nxfilter \
  && rm -f *.zip \
  && chmod +x /nxfilter/bin/startup.sh

#CMD ["/nxfilter/bin/startup.sh","start"]
CMD ["/nxfilter/bin/startup.sh"]
