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



