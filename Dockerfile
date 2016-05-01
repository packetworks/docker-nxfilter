#
#  NxFilter base image
#

FROM 1science/java:oracle-jre-7

MAINTAINER Charles Gunzelman

# Download nxfilter

#RUN echo "http://www.nxfilter.org/"$(curl -sL nxfilter.org/download.php|grep zip|grep nxfilter|head -n1|sed -e 's/<a .*href=['"'"'"]//' -e 's/["'"'"'].*$//'  -e '/^$/ d'|tr -d '[:blank:]') > url
#RUN wget -q --convert-links http://www.nxfilter.org/download.php ; cat download.php | sed -e 's/<a .*href=['"'"'"]//' -e 's/["'"'"'].*$//' -e '/^$/ d'|tr - d '[:blank:]'|grep zip|grep /nxfilter| head -n1 > url
#RUN wget -r --no-parent -A 'nxfilter*.zip' http://www.nxfilter.org/download.php

RUN curl -s -L http://www.nxfilter.org/|grep Download|sed -e 's/<a /\n<a /g'|sed -e 's/<a .*href=['"'"'"]//' -e 's/["'"'"'].*$//' -e '/^$/ d'|xargs -n1 curl -s -L|grep zip|sed -e 's/<a /\n<a /g'|sed -e 's/<a .*href=['"'"'"]//' -e 's/["'"'"'].*$//' -e '/^$/ d'|grep -v dropbox|grep -v logon|grep -v cloud|grep zip \
    && mkdir /nxfilter \
    && unzip nxfil* -d /nxfilter
