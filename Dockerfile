FROM debian

MAINTAINER Charles Gunzelman
LABEL org.label-schema.docker.dockerfile="/Dockerfile" \
      org.label-schema.vcs-type="Git" \
      org.label-schema.vcs-url="https://github.com/packetworks/docker-nxfilter"
ENV container docker

RUN apt -y update \ 
  && apt -y upgrade \
  && apt -y install wget unzip default-jre-headless libtcnative-1 libapr1 libapr1-dev \
  && apt -y clean autoclean \
  && apt -y autoremove \
  && rm -rf /var/lib/apt && rm -rf /var/lib/dpkg && rm -rf /var/lib/cache && rm -rf /var/lib/log

# Include the SSL-Split binary, not used by default.
COPY --from=vimagick/sslsplit /usr/ /

# Populate ingredients from Git repo.
COPY entrypoint.sh url.txt /

# Download and unzip nxfilter
RUN wget -i url.txt -O nxfilter.zip \
  && mkdir /nxfilter \
  && unzip nxfilter.zip -d /nxfilter \
  && chmod +x /nxfilter/bin/startup.sh \
  && rm -f nxfilter.zip

ENTRYPOINT ["/entrypoint.sh"]
CMD ["/nxfilter/bin/startup.sh"]
