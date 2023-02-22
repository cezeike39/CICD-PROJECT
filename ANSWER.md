# Architectural Design for 3 Appliation Services
This articture explains at high level the design of how we can achieve a resilient, highly available, scalable and productive applications With CICD automation.
The main automation tool (Jenkins/CircleCI/gitLab/gitHub Action etc.) in this architecture plays a signifcant role. It connects and integrate all other tools 
together to achieve what we termed CICD.

Belows are the stages/steps involved

# Stage 1: Cloning the Code 
The automation tool integrated with the SCM (github), and cloned the repo which contains all the files for the application.

# Stage 2: Building a package
The automation tool integrate with the build server (maven, gradle etc. depending on the src language) to build an artifact which can be deployed into the application server.
This build is necessary especially for a java application as the src are written in language that can not be read by the computer and a tool like maven can help to 
validate, compile, run a unit test and build an artifact using the build script (pom.xml file).

# stage 3: Code quality Analysis
in stage 3, the automation tool is integrated with the code quality tool like sonarqube to do static code analysis. This stage is necessary as it helps to check if
there is any vulnerabilities, bugs, code smell, security hot spot in the code. This helps to detect any issue at an early stage. It also helps to check the code 
coverage. (i.e does the developer write a sufficient unit test to ensure high quaity of the code).

# stage 4: Backup the artifacts
In this stage, the artifactory is integrated with the automation tools where the package built would be stored. This is aimed at preventing a single point of failure 
(disaster recovery) just in case the build server goes down then we can restore our software from the backup server.

The above stages (1 to 4 ) is what is called continuous integration which is aimed at continuously testing our code for bug issues and hence we can detect this earlier.

# stage 5: Testing in UAT enviroment
In this stage, after the completion of continuous integration processes, further test is required to check for the application performance, integration, regression, 
load balance and etc. which is usually done at in staging/UAT environment before it is taking to production. If the processes are manaully done whereby a manual approval is required, it is termed a continuous delivery otherwise it is termed continuous deployment.

# stage 6: Deployment Stage
This is final stage of the CICD process and after these applications have been deploying into the application server. 
Here to achieve high  availability, and sacalability for each of the 3 services (A, B and C). The below design will be considered.

# 1. Availability:
each of the services may be placed in 2 different availabilty zones and also backup them up in another region. This however 
comes at cost. The choice would largely depends on our priority. 

# 2. Scalability:
The services are placed behind auto scaling group (ASG) in which we can automatically scale in and out (horizontal scaling) the server in which they are running.
Each service would have its own target group (i.e Target Grp1, Target Grp2, Target Grp3) and managed by ASG.

# 3. Productivity:
The Application Load Balancer (ALB) is placed in front the 3 services to distribute the traffic across the target based on the content of the incoming traffic.
The ALB helps to load balance the traffic from the users and route the traffic based on the rules configured. i.e if there is a request with url https://abc/serviceA, https://abc/ServiceB etc, the ALB will intelligently route the traffic to the right service based.

Finally, the Route 53 in the architecture helps with the DNS resolution (Domain Name Service). It helps to resolve the address coming from the client into a format (IP) that can be read by the Load Balancer. 
Also, it is worthy to note that 3 services are placed in a private subnet and the ALB inside the public subnet to prevent the client traffic from the internet to directly hit  these applications. Hence the ALB acts as a proxy to route the cleint traffice to the 3 applications.
resources 
   

