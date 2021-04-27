[![](https://images.microbadger.com/badges/image/packetworks/nxfilter-base:debian.svg)](https://microbadger.com/images/packetworks/nxfilter-base:debian "Get your own image badge on microbadger.com") [![Docker Stars](https://img.shields.io/docker/stars/packetworks/nxfilter-base.svg)](https://hub.docker.com/r/packetworks/nxfilter-base/) [![Docker Pulls](https://img.shields.io/docker/pulls/packetworks/nxfilter-base.svg)](https://hub.docker.com/r/packetworks/nxfilter-base/)
  
![](https://nxfilter.org/p3/wp-content/uploads/2013/10/rb_logo41.png)  
 
[NxFilter](http://www.nxfilter.org/) - An easy to use DNS server with configurable filters and user controls.
  
This image is based on official [debian](https://hub.docker.com/_/debian) and sacrifices image size for performance.
MultiArch builds are now in place for x86_64,i386,ARMv6,ARMv7,ARM64

# Supported Tags

-	[`latest`](https://github.com/packetworks/docker-nxfilter/tree/nxfilter-latest)
-	[`debian`](https://github.com/packetworks/docker-nxfilter/tree/nxfilter-debian)

# Usage  

**For a single persistent container:**  
```
docker run -it \
  --name nxfilter \
  -p 80:80 -p 443:443\
  -p 53:53/udp \
  packetworks/nxfilter-base:debian
```  
```-it``` starts the container in Interactive mode with a TTY. ```-p``` forwards a port into the container, other ports are needed to utilize all features of nxfilter. 53 UDP is to accept DNS queries coming in, 80 is for the WebUI. The interactive console can be sent to the background with CTRL-P + CTRL-Q.
  
  
  
**For a transient container with a persistent data volumes**  
```
docker run -dt \
  --name nxfilter \
  -v nxfilter-conf:/nxfilter/conf \
  -v nxfilter-log:/nxfilter/log \
  -v nxfilter-db:/nxfilter/db \
  -p 80:80 -p 443:443 -p 53:53/udp \
  -p 19002-19004:19002-19004 \
  packetworks/nxfilter-base:debian
```

This will run the container in the background like a service, with a persistent data volume mounted for each folder that nxfilter modifies data in. Ports 80 and 53 are forwarded to the container for accessing NxFilter admin interface and accepting DNS queries. You may add ```--rm``` so the container will be removed after stopping. All changes will be saved in volumes.
