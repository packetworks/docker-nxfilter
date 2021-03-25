FROM 1science/java:oracle-jre-8

MAINTAINER Charles Gunzelman "cgunzelman@gmail.com"
LABEL org.label-schema.docker.dockerfile="/Dockerfile" \
      org.label-schema.vcs-type="Git" \
      org.label-schema.vcs-url="https://github.com/packetworks/docker-nxfilter"

COPY entrypoint.sh url.txt /

# Download and extract nxfilter
RUN wget -i url.txt -O nxfilter.zip \
  && mkdir /nxfilter \
  && unzip nxfilter.zip -d /nxfilter \
  && chmod +x /nxfilter/bin/startup.sh \
  && rm -f nxfilter.zip

# Not enabled by default
COPY --from=vimagick/sslsplit / /

ENTRYPOINT ["/entrypoint.sh"]

CMD ["/nxfilter/bin/startup.sh"]
