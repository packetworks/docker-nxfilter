#
# Latest NxFadmin from bitbucket repo
#

FROM packetworks/nxfilter:nxfilter-latest

RUN wget https://bitbucket.org/DeepWoods/nxfadmin/get/master.zip
RUN mkdir /nxfilter/skins
RUN unzip master.zip -d /nxfilter/skins/
RUN mv /nxfilter/skins/De*/skins/nxfadmin /nxfilter/skins/
RUN rm -rf /nxfilter/skins/De*
RUN rm -f *.zip
RUN echo "www_dir = skins/nxfadmin" >> /nxfilter/conf/cfg.default
CMD /nxfilter/bin/startup.sh
