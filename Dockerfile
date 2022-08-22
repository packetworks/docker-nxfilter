FROM debian AS builder

MAINTAINER Charles Gunzelman

RUN apt -y update \
  && apt -y upgrade \
  && apt -y install wget unzip libtcnative-1 libapr1 libapr1-dev

# Populate ingredients from Git repo.
COPY url.txt /

# Download and unzip nxfilter from nxfilter.org
RUN wget -nv -i url.txt -O nxfilter.zip \
  && mkdir /nxfilter \
  && unzip -q nxfilter.zip -d /nxfilter \
  && rm -f nxfilter.zip


########
########

FROM gcr.io/distroless/java:8

MAINTAINER Charles Gunzelman
LABEL org.label-schema.docker.dockerfile="/Dockerfile" \
      org.label-schema.vcs-type="Git" \
      org.label-schema.vcs-url="https://github.com/packetworks/docker-nxfilter"

# Deconstruct startup.sh
ENV container=docker \
    PATH=$PATH:/usr/bin:/usr/local/bin \
    CLASSPATH=$NX_HOME/nxd.jar:$NX_HOME/lib/*: \
    NX_HOME=/

# Include SSL-Split binary, not used by default.
COPY --from=vimagick/sslsplit /usr/local/bin/sslsplit /usr/local/bin/

# Copy packages from Builder.
# COPY --from=builder /usr/lib/x86_64-linux-gnu/ /usr/lib/x86_64-linux-gnu/ #got an error with this one at build time
COPY --from=builder /usr/share/lintian/overrides /usr/share/lintian/overrides
COPY --from=builder /usr/bin/apr-1-config /usr/bin/apr-config /usr/bin/
COPY --from=builder /usr/include/apr-1.0 /usr/include/apr-1.0
COPY --from=builder /nxfilter /
COPY --from=builder /bin/hostname /bin/

# Deconstruct startup.sh
ENTRYPOINT ["java"]
CMD [ "-Djava.net.preferIPv4Stack=true", "-Xmx768m", "-Djava.security.egd=file:/dev/./urandom", "nxd.Main" ]
