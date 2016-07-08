#
#  NxFilter base image
#

FROM 1science/java:oracle-jre-7

MAINTAINER Charles Gunzelman

# Download nxfilter
RUN wget -q http://www.nxfilter.org/download/nxfilter-3.3.4.zip

RUN mkdir /nxfilter \
  && unzip nxfil* -d /nxfilter \
  && rm -f *.zip \
  && chmod +x /nxfilter/bin/startup.sh
  
CMD /nxfilter/bin/startup.sh
