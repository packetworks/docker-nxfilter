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
  |xargs -n1 wget -q && mkdir -p /nxfilter \
  && unzip -o nxfil* -d /nxfilter \
  && cp /nxfilter/conf /nxfilter/conf-bak \
  && chmod +x /nxfilter/bin/startup.sh \
  && rm -f *.zip

COPY --from=vimagick/sslsplit / /
VOLUME /nxfilter/config
VOLUME /nxfilter/db
VOLUME /nxfilter/log

CMD ["/nxfilter/bin/startup.sh"]
