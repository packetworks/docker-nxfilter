#
#  NxFilter base image
#

FROM 1science/java:oracle-jre-7

MAINTAINER Charles Gunzelman

# Download nxfilter
RUN wget -q http://nxfilter.org/download/nxfilter-3.0.9.zip
RUN mkdir /nxfilter
RUN unzip nxfil* -d /nxfilter
RUN rm -f *.zip
RUN chmod +x /nxfilter/bin/startup.sh
CMD /nxfilter/bin/startup.sh
