Build Project Using Maven
Maven is java based build tool to generate executable

packages(jar, ear,war) for java based projects.

mvn clean package
Create Docker Image
Docker is a continerization tool.Using docker we can deploy our applications as

containers using docker images. Containers contains application code and also the softwares,

config files whatever is required for our application to run.

Create docker image using Dockerfile

docker build -t mylandmarktech/springapp .
Deploy Application Using Docker Compose
docker-compose up -d 
List Docker Containers
docker ps -a
License
