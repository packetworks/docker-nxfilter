#
#  NxFilter base image
#

FROM 1science/java:oracle-jre-7

MAINTAINER Charles Gunzelman

# Download nxfilter
RUN wget http://nxfilter.org/download/nxfilter-2.8.4.zip
    mkdir /nxfilter
    unzip nxfil* -d /nxfilter
