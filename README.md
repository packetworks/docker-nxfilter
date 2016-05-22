[![](https://badge.imagelayers.io/packetworks/nxfilter-base:latest.svg)](https://imagelayers.io/?images=packetworks/nxfilter-base:latest 'Get your own badge on imagelayers.io') << The image is not really 0 Bytes, usually around 180MB  
  
![nothing](http://www.nxfilter.org/p2/wp-content/uploads/2014/07/rb_logo41.png)  

# What is NxFilter?
  
[Home Page](http://www.nxfilter.org/)  
An easy to use DNS server with configurable filters and user controls.
  
This image is based on: [1science/java](https://registry.hub.docker.com/u/1science/java/) which uses Alpine Linux as a base, and they have slimmed down the Java install footprint on the system.

# Supported Tags

-        [`latest`](https://github.com/packetworks/docker-nxfadmin/tree/nxfilter-latest)

# Usage:

## For a single persistent container:

Create your persistent container:  
```docker run -it nxfilter-data -p 80:80 -p 53:53/udp packetworks/nxfilter-base:latest```  
```-it``` starts the container in Interactive mode. It's more complicated than that, but the man pages have more info. ```-p``` forwards a port into the container. We are specifying two different ports here, one for the Web console, and 53 for DNS. You can disconnect from the interactive container with CTRL-P + CTRL-Q.

## For a transient container with a separate data container:

- ```   WARNING  ```  

```THIS IS NOT TESTED```  

- ```   WARNING  ```  

### Create your persistent data container with:  
```docker run -d -v /nxfilter/db --name nxfilter-data --entrypoint /bin/echo busybox nxfilter-data``` The data container will start in the background because of ```-d```, then exit. This is normal. It will not show up in ```docker ps```, only with ```docker ps -a``` because it is not actually running. We specified the volume it will present to other containers with ```-v```. Your NxFilter container will use the volume presented by data container, but data container will not ever run except the second you created it.  
  
### Create your transient application container with:  
```docker run --volumes-from nxfilter-data -p 80:80 -p 53:53/udp --rm packetworks/nxfilter-base:latest /nxfilter/bin/startup.sh```

This will run the container interactively, with a persistent data volume mounted from the data container. Ports 80 and 53 are forwarded to the container for accessing NxFilter admin interface and for sending DNS queries to it. ```--rm``` specifies the container will not persist any changes after stopping. All changes will need to be made in volumes from other containers, or you can mount host directories, or go back to the section labelled ```single persistent container:```

old command: ```docker run -it --volumes-from nxfilter-data -p 80:80 -p 53:53 -t --rm packetworks/nxfilter:latest```


# To Do:
- Finish testing automated builds and webhooks to completely automate the process.

# Done:
- Create Docker file for both images. Shouldn't be too hard.
- Set up automated builds of the images.
