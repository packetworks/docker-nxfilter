#
#  NxFilter base image
#

FROM 1science/java:oracle-jre-7

MAINTAINER Charles Gunzelman

# Download nxfilter
RUN wget http://nxfilter.org/download/nxfilter-2.8.4.zip
RUN mkdir /nxfilter
RUN unzip nxfil* -d /nxfilter
run rm -f *.zip
RUN chmod +x /nxfilter/bin/startup.sh
CMD /nxfilter/bin/startup.sh
