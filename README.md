# CI/CD Pipeline for Java Application Deployment

This project demonstrates a full CI/CD pipeline for building and deploying a Java application using both **GitHub Actions** and **Jenkins**, with integrations for code analysis, artifact storage, Docker, and Kubernetes.

---

## 📦 What This Project Does

The project builds a `.jar` file using Maven and automates the process through both:

- **GitHub Actions**
- **Jenkins (on a self-hosted runner)**

The pipeline handles:

- ✅ Code compilation and build
- ✅ Code quality analysis via **SonarQube**...
- ✅ Artifact storage via **Nexus**
- ✅ Docker image creation and push to **Docker Hub**
- ✅ Kubernetes deployment using **Kops**
- ✅ Exposure via a **LoadBalancer Service**...

---

## 🔧 Technologies Used

| Tool         | Purpose                              |
|--------------|--------------------------------------|
| **Maven**    | Build tool for Java project          |
| **GitHub Actions** | CI/CD automation workflows     |
| **Jenkins**  | Alternative CI/CD pipeline execution |
| **Docker**   | Containerization of the application  |
| **SonarQube**| Code quality and security analysis   |
| **Nexus**    | Artifact repository for `.jar` files |
| **Kubernetes (Kops)** | Cluster creation & deployment |
| **kubectl**  | K8s management CLI                   |
| **Helm**     | K8s Package manager                  | 

---

## 🚀 GitHub Actions Workflow

- Compiles and builds the JAR file with Maven.
- Runs code quality and security checks with **SonarQube**.
- Uploads the artifact to **Nexus**.
- Builds a Docker image from the JAR.
- Pushes the image to Docker Hub: [`cezeike39/docker`](https://hub.docker.com/u/cezeike39).
- Deploys the Docker container to a Kubernetes cluster using Kops.
- Exposes the application via a **LoadBalancer** service.

> ✅ GitHub Actions handles **end-to-end CI/CD** and **automated deployment to Kubernetes**.

---

## 🔁 Jenkins Pipeline

The `Jenkinsfile` replicates the core CI/CD stages:

- Build JAR
- Push to SonarQube and Nexus
- Build Docker image
- Push to Docker Hub

> 🚨 Jenkins does **not deploy to Kubernetes** in this project.

- Jenkins jobs are executed on a **self-hosted agent** that includes:
  - `docker`, `maven`, `kops`, and `kubectl` pre-installed

---

## 🖥 Self-hosted Runner Details

- A separate server was configured as the **self-hosted runner** for both GitHub Actions and Jenkins.
- Tools installed on the runner:
  - Docker
  - Maven
  - Kops
  - kubectl

> This setup allows full control and flexibility over the build environment.

---

## 🧪 External Services

- **SonarQube** and **Nexus** were hosted on a separate dedicated server.
- The Kubernetes cluster was managed via **Kops** and deployed on **AWS**.

---

## 🌐 Accessing the Application

Once deployed, the application is available through a public **LoadBalancer** in Kubernetes.

You can view the service using:

```bash
kubectl get svc
```

## ⛵ Helm Deployment

This project now supports **deployment using Helm** for easier management of Kubernetes resources.

- The Helm chart is located in `cicd-helmchart/`.
- It deploys:
  - The Java application (`cicd-helmchart` deployment)
  - MongoDB (`mongo-deployment`)
  - ConfigMaps and Secrets
  - Horizontal Pod Autoscaler (HPA)
- The Helm chart handles:
  - Labels, annotations, and namespaces
  - Service exposure via **NodePort** or **LoadBalancer**
---

### Deploying via Helm

1. Install the release:

```
helm install <name>  cicd-helmchart 
```
### Local Deployment with Docker Compose

For local development or testing, you can use Docker Compose to run the Java application and MongoDB without a Kubernetes cluster.

Start the services

From the root of the project (where docker-compose.yml is located):

```
docker-compose up -d
```
### Verify the containers

```
docker-compose ps
```
### Stop the services
```
docker-compose down -d
```
