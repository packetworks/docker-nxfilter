[![](https://images.microbadger.com/badges/image/packetworks/nxfadmin.svg)](https://microbadger.com/images/packetworks/nxfadmin "Get your own image badge on microbadger.com") [![Docker Stars](https://img.shields.io/docker/stars/packetworks/nxfadmin.svg)](https://hub.docker.com/r/packetworks/nxfadmin/) [![Docker Pulls](https://img.shields.io/docker/pulls/packetworks/nxfadmin.svg)](https://hub.docker.com/r/packetworks/nxfadmin/)
  
![](https://nxfilter.org/p3/wp-content/uploads/2013/10/rb_logo41.png)  
![](https://barmakapproved.files.wordpress.com/2012/07/notapproved.png?w=300)
## Do not use the NxFadmin branch until further notice. There are a few features missing according to the NxFadmin maintainer. More details here:
## https://groups.google.com/forum/?fromgroups=&hl=en#!topic/nxfilter200/ryc071Xn4aY  
This repo is still available for those who are fine with the GUI features of NxFilter 2.x
  
# What is NxFadmin?

[Project Page](https://bitbucket.org/DeepWoods/nxfadmin/src)  
A modern GUI for NxFilter.

# What is NxFilter?
  
[Home Page](http://www.nxfilter.org/)  
An easy to use DNS server with configurable filters and user controls.
  
This image is based on: [1science/java](https://registry.hub.docker.com/u/1science/java/) which uses Alpine Linux as a base, and they have slimmed down the Java install footprint on the system.

# Supported Tags

-        [`latest`](https://github.com/packetworks/docker-nxfilter/tree/nxfadmin)

# Usage:

## For a single persistent container:

Create your persistent container:  
```docker run -it nxfadmin -p 80:80 -p 53:53/udp packetworks/nxfadmin:latest```  
```-it``` starts the container in Interactive mode. It's more complicated than that, but the man pages have more info. ```-p``` forwards a port into the container. We are specifying two different ports here, one for the Web console, and 53 for DNS. You can disconnect from the interactive container with CTRL-P + CTRL-Q.

## For a transient container with a separate data container:

- ```   WARNING  ```  

```THIS IS NOT TESTED```  

- ```   WARNING  ```  

### Create your persistent data container with:  
```docker run -d -v /nxfilter/db --name nxfilter-data --entrypoint /bin/echo busybox nxfilter-data``` The data container will start in the background because of ```-d```, then exit. This is normal. It will not show up in ```docker ps```, only with ```docker ps -a``` because it is not actually running. We specified the volume it will present to other containers with ```-v```. Your NxFilter container will use the volume presented by data container, but data container will not ever run except the second you created it.  
  
### Create your transient application container with:  
```docker run --volumes-from nxfilter-data -p 80:80 -p 53:53/udp --rm packetworks/nxfadmin:latest```

This will run the container interactively, with a persistent data volume mounted from the data container. Ports 80 and 53 are forwarded to the container for accessing NxFilter admin interface and for sending DNS queries to it. ```--rm``` specifies the container will not persist any changes after stopping. All changes will need to be made in volumes from other containers, or you can mount host directories, or go back to the section labelled ```single persistent container:```



# To Do:
- Finish testing automated builds and webhooks to completely automate the process.

# Done:
- Create Docker file for both images. Shouldn't be too hard.
- Set up automated builds of the images.
