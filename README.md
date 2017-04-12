[![](https://images.microbadger.com/badges/image/packetworks/nxfilter-base.svg)](https://microbadger.com/images/packetworks/nxfilter-base "Get your own image badge on microbadger.com")
[![Docker Stars](https://img.shields.io/docker/stars/packetworks/nxfilter-base.svg)](https://hub.docker.com/r/packetworks/nxfilter-base/)
[![Docker Pulls](https://img.shields.io/docker/pulls/packetworks/nxfilter-base.svg)](https://hub.docker.com/r/packetworks/nxfilter-base/)
  
![nothing](http://www.nxfilter.org/p2/wp-content/uploads/2014/07/rb_logo41.png)  
 
[NxFilter](http://www.nxfilter.org/) - An easy to use DNS server with configurable filters and user controls.
  
This image is based on [1science/java](https://registry.hub.docker.com/u/1science/java/) for the slimmed down Java and overall container footprint.

# Supported Tags

-	[`experimental`](https://github.com/packetworks/docker-nxfilter/tree/nxfilter-experimental)

# Usage

**For a single persistent container:**
```docker run -it nxfilter -p 80:80 -p 53:53/udp packetworks/nxfilter-base:latest```  
```-it``` starts the container in Interactive mode. It's more complicated than that, but the man pages have more info. ```-p``` forwards a port into the container. We are specifying two different ports here, one for the Web console, and 53 for DNS. You can disconnect from the interactive container with CTRL-P + CTRL-Q.
  
  
  
  
**For a transient container with a persistent data container**

- ```   WARNING  ```  

```THIS IS NOT TESTED```  

- ```   WARNING  ```  

**Create your persistent data container:**  
```docker run -d -v /nxfilter/db --name nxfilter-data --entrypoint /bin/echo busybox nxfilter-data``` The data container will start in the background because of ```-d```, then exit. This is normal. It will not show up in ```docker ps```, only with ```docker ps -a``` because it is not actually running. We specified the volume it will present to other containers with ```-v```. Your NxFilter container will use the volume presented by data container, but data container will not ever run except the second you created it.  
  
**Create your transient application container:**  
```docker run --volumes-from nxfilter-data -p 80:80 -p 53:53/udp --rm packetworks/nxfilter-base:latest /nxfilter/bin/startup.sh```

This will run the container interactively, with a persistent data volume mounted from the data container. Ports 80 and 53 are forwarded to the container for accessing NxFilter admin interface and for sending DNS queries to it. ```--rm``` specifies the container will not persist any changes after stopping. All changes will need to be made in volumes from other containers, or you can mount host directories, or go back to the section labelled ```single persistent container:```

old command: ```docker run -it --volumes-from nxfilter-data -p 80:80 -p 53:53 -t --rm packetworks/nxfilter:latest```


# To Do
- Fully test running in an automated encironment like Shipyard or 

# Done
- Create Docker file for both images. Shouldn't be too hard.
- Set up automated builds of the images.
- Finish testing automated builds and webhooks to completely automate the process.
