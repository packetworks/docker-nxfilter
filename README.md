[![](https://images.microbadger.com/badges/image/packetworks/nxfilter-base.svg)](https://microbadger.com/images/packetworks/nxfilter-base "Get your own image badge on microbadger.com")  [![Docker Stars](https://img.shields.io/docker/stars/packetworks/nxfilter-base.svg)](https://hub.docker.com/r/packetworks/nxfilter-base/)  [![Docker Pulls](https://img.shields.io/docker/pulls/packetworks/nxfilter-base.svg)](https://hub.docker.com/r/packetworks/nxfilter-base/)
  
![nothing](http://www.nxfilter.org/p2/wp-content/uploads/2014/07/rb_logo41.png)  
 
[NxFilter](http://www.nxfilter.org/) - An easy to use DNS server with configurable filters and user controls.
  
This image is based on [1science/java](https://registry.hub.docker.com/u/1science/java/) for the slimmed down Java and overall container footprint.

# Supported Tags

-	[`latest`](https://github.com/packetworks/docker-nxfilter/tree/nxfilter-latest)
-	[`experimental`](https://github.com/packetworks/docker-nxfilter/tree/nxfilter-experimental)

# Usage

**For a single persistent container:**  
```docker run -it nxfilter -p 80:80 -p 53:53/udp packetworks/nxfilter-base:latest```  
```-it``` starts the container in Interactive mode. It's more complicated than that, but the man pages have more info. ```-p``` forwards a port into the container. We are specifying two different ports here, one for the Web console, and 53 for DNS. You can disconnect from the interactive container with CTRL-P + CTRL-Q.
  
  
  
  
**For a transient container with a persistent data volumes**
```docker run -dt \
  --name nxfilter  \
  -v nxfilter-conf:/nxfilter/conf   \
  -v nxfilter-log:/nxfilter/log  \
  -v nxfilter-db:/nxfilter/db  \
  -p 80:80  -p 53:53/udp  \
  --expose 19002-19004  \
  packetworks/nxfilter-base:latest
  ```

This will run the container in the background like a service, with a persistent data volume mounted for each folder that nxfilter modifies data in. Ports 80 and 53 are forwarded to the container for accessing NxFilter admin interface and accepting DNS queries. You may add ```--rm``` so the container will be removed after stopping. All changes will be saved in volumes.



# To Do
- Fully test running in an automated encironment like Shipyard or TravisCI

# Done
- Create Docker file for both images. Shouldn't be too hard.
- Set up automated builds of the images.
- Finish testing automated builds and webhooks to completely automate the process.
