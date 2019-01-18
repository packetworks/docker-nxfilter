FROM 1science/java:oracle-jre-8

MAINTAINER Charles Gunzelman "cgunzelman@gmail.com"

# Download nxfilter
RUN wget --spider --force-html -r -l1 \
  http://www.nxfilter.org/download.php 2>&1 \
  | grep '^--' | awk '{ print $3 }' \
  | grep 'nxfilter-' | grep 'zip' \
  | grep -v 'cloud' | head -n1 > url.txt \
  && wget -i url.txt

RUN mkdir /nxfilter \
  && unzip nxfil* -d /nxfilter \
  && rm -f *.zip \
  && chmod +x /nxfilter/bin/startup.sh

#CMD ["/nxfilter/bin/startup.sh","start"]
CMD ["/nxfilter/bin/startup.sh"]
