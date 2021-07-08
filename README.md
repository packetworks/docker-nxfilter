[![](https://images.microbadger.com/badges/image/packetworks/nxfilter-base.svg)](https://microbadger.com/images/packetworks/nxfilter-base "Get your own image badge on microbadger.com")  [![Docker Stars](https://img.shields.io/docker/stars/packetworks/nxfilter-base.svg)](https://hub.docker.com/r/packetworks/nxfilter-base/)  [![Docker Pulls](https://img.shields.io/docker/pulls/packetworks/nxfilter-base.svg)](https://hub.docker.com/r/packetworks/nxfilter-base/)
  
![](https://nxfilter.org/p3/wp-content/uploads/2013/10/rb_logo41.png)  
 
[NxFilter](http://www.nxfilter.org/) - An easy to use DNS server with configurable filters and user controls.
  
This image is based on [1science/java](https://registry.hub.docker.com/u/1science/java/) for the slimmed down Java and overall container footprint.

# Supported Tags  

-	[`latest`](https://github.com/packetworks/docker-nxfilter/tree/nxfilter-latest)
-	[`debian`](https://github.com/packetworks/docker-nxfilter/tree/nxfilter-debian)

# Usage  

## docker-compose.yml

```yaml
nxfilter:
  image: packetworks/nxfilter-base:latest
  tty: true
  volumes:
    - nxfilter-conf:/nxfilter/conf
    - nxfilter-log:/nxfilter/log
    - nxfilter-db:/nxfilter/db
  restart: unless-stopped
  ports:
    - 80:80
    - 443:443
    - 53:53/udp
    - 19002-19004:19002-19004
```  

**Single persistent container:**  
```
docker run -it \
  --name nxfilter \
  --restart unless-stopped \
  -p 80:80 -p 443:443\
  -p 53:53/udp \
  packetworks/nxfilter-base:latest
```  
```-it``` starts the container in Interactive mode with a TTY.  
```-p``` forwards a port into the container, other ports are needed to utilize all features of nxfilter.  
Port 53 UDP is for incoming DNS queries, port 80 is for the WebUI.  
The interactive console can be sent to the background with CTRL-P + CTRL-Q.
  

  
**Transient container with a persistent data volumes:**
```
docker run -dt \
  --name nxfilter \
  --restart unless-stopped \
  -v nxfilter-conf:/nxfilter/conf \
  -v nxfilter-log:/nxfilter/log \
  -v nxfilter-db:/nxfilter/db \
  -p 80:80 -p 443:443 -p 53:53/udp \
  -p 19002-19004:19002-19004 \
  packetworks/nxfilter-base:latest
```
This will run the container in the background like a service, with all user data saved in separate docker volumes.
  
  
   
## A much deserved Thank You to contributors and testers  
Daniel Gibbs  
Vincent Tacquet  
Adam Trust  
Daniele (brugnara)  
Nathan Sanders  
.
