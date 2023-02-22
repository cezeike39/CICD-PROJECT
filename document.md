Building and Deploying a Java Application with Maven and Docker to a Minikube Kubernetes Cluster Using GitHub Actions

This guide provides step-by-step instructions on how to build and deploy a Java project using Maven and Docker into a Minikube Kubernetes Cluster.
The project consists of 2 services (micro-service): Reg-app and Mongodb. We will use Apache Maven to build the an artifact from the src suitable 
for deployment and use docker engine to build an image which can be run as a container inside K8s cluster. The mongodb official image from the dockerhub
registry will be deployed as a container inside the cluster and help us to store the data from the application.
We will use GitHub Actions which will help us to automate the processes involve to achieve Continuous Integration and Continous Deployment (CICD).
GitHub Action uses manifest file to automate the CICD process. and it is also included in this file.



Prerequisites
Before you begin, make sure you have the following software installed:

Java Development Kit (JDK) version 11 or later
Apache Maven
Docker
Kubernetes Cluster (Minikube/docker-desktop)
kubectl (Kubernetes command-line tool)

Step 1: Create a repository in GitHub to manage the files
Make sure your project has a pom.xml file for Maven to build your project.

Step 2: Build the Project with Maven
Run the following command in the root directory of your project to build the project using Maven:
mvn clean install
This command will validate and compile the project, run unit tests, and package the project into a JAR file.

Step 3: Create a Dockerfile
Create a Dockerfile in the root directory of your project with the following sample content:

FROM openjdk:8-alpine
COPY target/<your-project-name>.jar app.jar
ENTRYPOINT ["java","-jar","/app.jar"]

This Dockerfile will use the openjdk:8-jdk-alpine image as the base image (ensure to scan the image to check for vulnerabilities), copy the JAR file built by Maven into the container, and set the JAR file as the entry point.
  
Step 4: Build a Docker Image
Run the following command in the root directory of your project to build a Docker image:
docker build -t <your-docker-username>/<your-repo-name>:<version> .
Replace <your-docker-username> with your Docker username, <your-project-name> with the remote repository of your project, and <version> with the version/tag of your project.

Step 5: Deploy the Docker Image to Minikube K8s Cluster
It is assumed your K8s cluster has been setup and configured (pls refer to k8s documentation on how to setup K8s Cluster).
And also the manifest files for all the objects (deployments, replicaset, secret, service, etc) required for the deployment of the applications are already written

Deploy the Docker image to Minikube by running the following command:

kubectl apply -f <manifest.yml>

This will deploy and run the application as a container inside K8s cluster.
  
Step 5: Testing the Application
verify the application id it is running by running the follwing command in k8s cluster:

kuebctl get pods # to check the pod status
kubectl get endpoints # to check if the service is routing the traffic to the pod
kubectl get service # to get the service IPs and port 
 
we used two services here: cluster IP service for mongodb ( to allow our application to communicate internally with the db) and Nodeport IP service for the Reg-app (to allow the external traffic into the cluster. i.e. external traffic can reach the application via the service).

 use the command to test the applications
  curl -v <nodePortIP:nodePor> 
  curl -v <localhost:<nodePort>







