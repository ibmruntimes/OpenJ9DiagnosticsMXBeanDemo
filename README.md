## OpenJ9DiagnosticsMXBean Demo

To demonstrate the usage of the MXBean, we have created a docker image of a Helloworld servlet with open liberty server and the AdoptOpenJDK openjdk8-openj9 [nightly docker build](https://hub.docker.com/r/adoptopenjdk/openjdk8-openj9/tags/) and pushed it to hub.docker.com, you can find it [here](https://hub.docker.com/r/chandra25ms/helloworld-openjdk8-openj9-mxbean/).

### Follow the below steps on a Linux machine to deploy the demo on ICP:
- git clone https://github.com/ibmruntimes/OpenJ9DianosticsMXBeanDemo.git
- Login to the ICP server and click on the logged in user and go to configure client option
- Copy the kubectl commands from the configure client option and execute these commands on the linux machine
- Configure a [NFS persistent volume](https://www.ibm.com/developerworks/community/blogs/fe25b4ef-ea6a-4d86-a629-6f87ccf4649e/entry/Working_with_storage?lang=en_us)
  and update the NFS Server IP Addr and path in the below section in "hello-deploy-dockerhub.yaml"
        __nfs:__
            __server: <IP Addr of NFS Server>__
            __path: <NFS server path to store the dumps>__

- Execute kubectl-create.sh to deploy the application from the docker hub link specified above and to create a service
- Login to ICP and check if the application is deployed and service is running or use the below command:

  ```kubectl get pods ```
- Check the application logs from the linux machine by issuing the below command:

   ```kubectl logs -f -c <container> <pod name>```

  For example,
  
  ```kubectl logs -f -c hello-mxbean-vol hello-mxbean-vol-ddcbb8688-2fj2n```

Note - To connect to the liberty application using JMX, we need to enable the restConnector feature that in turn uses ssl. The restConnector and ssl feature have been enabled in the server.xml. You can refer to [configuring secure JMX connection to liberty](https://www.ibm.com/support/knowledgecenter/en/SSAW57_liberty/com.ibm.websphere.wlp.nd.multiplatform.doc/ae/twlp_admin_restconnector.html) for details.

We have created a self-signed certificate and ssl keys (keystore.jks) using [keytool](https://docs.oracle.com/javase/8/docs/technotes/tools/windows/keytool.html#keytool_option_genkeypair) for testing purpose. 


### How to re-build the docker image?

If you would like to re-create the docker image and push it to your docker hub registry, follow the below steps:
- Execute the below command to re-create the liberty image with adopt openjdk8-openj9 nightly build
 
   ```./liberty.sh```
- Push the docker image created to your hub docker registry and update the below image location in "hello-deploy-dockerhub.yaml" to point to your hub docker registry

   *image: "index.docker.io/chandra25ms/helloworld-openjdk8-openj9-mxbean"*
