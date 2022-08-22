FROM 1science/java:oracle-jre-8

MAINTAINER Charles Gunzelman "cgunzelman@gmail.com"
LABEL org.label-schema.docker.dockerfile="/Dockerfile" \
      org.label-schema.vcs-type="Git" \
      org.label-schema.vcs-url="https://github.com/packetworks/docker-nxfilter"

# Include the SSL-Split binary, not used by default.
COPY --from=vimagick/sslsplit /usr/local/bin/sslsplit /usr/local/bin/

COPY entrypoint.sh url.txt /

# Fix DNS
# RUN apk add --update bind-tools

# Download and extract nxfilter
RUN xargs </url.txt curl -o nxfilter.zip -s \
  && mkdir /nxfilter \
  && unzip -q nxfilter.zip -d /nxfilter \
  && chmod +x /nxfilter/bin/startup.sh \
  && rm -f nxfilter.zip

EXPOSE 80
EXPOSE 443
EXPOSE 53/udp
EXPOSE 19002
EXPOSE 19003
EXPOSE 19004

ENTRYPOINT ["/entrypoint.sh"]

CMD ["/nxfilter/bin/startup.sh"]
