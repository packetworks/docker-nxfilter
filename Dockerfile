#
# Latest NxFadmin from bitbucket repo
#

FROM packetworks/nxfilter:nxfilter-latest

RUN wget https://bitbucket.org/DeepWoods/nxfadmin/get/master.zip
    mkdir /nxfilter/skins
    unzip master.zip -d /nxfilter/skins/
    mv /nxfilter/skins/De*/skins/nxfadmin /nxfilter/skins/
    rm -rf /nxfilter/skins/De*
    rm -f *.zip
    echo "www_dir = skins/nxfadmin" >> /nxfilter/conf/cfg.default
CMD /nxfilter/bin/startup.sh
