FROM 1science/java:oracle-jre-8

MAINTAINER Charles Gunzelman "cgunzelman@gmail.com"
LABEL org.label-schema.docker.dockerfile="/Dockerfile" \
      org.label-schema.vcs-type="Git" \
      org.label-schema.vcs-url="https://github.com/packetworks/docker-nxfilter"
      
# Download nxfilter
RUN curl -s -L http://www.nxfilter.org/|grep Download \
  |grep -Eo "(http|https)://[a-zA-Z0-9./?=_-]*" \
  |grep download|uniq \
  |xargs -n1 curl -s -L \
  |grep -Eo "(http|https)://[a-zA-Z0-9./?=_-]*" \
  |grep filter-.*zip|grep -v mediafire \
  |xargs -n1 wget -q && mkdir /nxfilter \
  && unzip nxfil* -d /nxfilter \
  && chmod +x /nxfilter/bin/startup.sh \
  && rm -f *.zip

COPY --from=vimagick/sslsplit / /

#CMD ["/nxfilter/bin/startup.sh","start"]
CMD ["/nxfilter/bin/startup.sh"]
