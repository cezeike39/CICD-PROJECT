pipeline{
    agent any
    environment {
        KUBECONFIG_CREDENTIAL = credentials('')
    }
    tools{
       maven "maven3.9.2"
    }
    stages{
        stage('CLONE_GITHUB'){
            steps{
                sh "echo 'cloning from github repo'"
                git branch: 'main', credentialsId: 'GITHUBCRED', url: 'https://github.com/master-card-proj/CICD-PROJECT.git'
            }
        }
        stage('TEST-BUILD'){
            steps{
                sh "echo 'testing and building artifact with maven'"
                sh "mvn install"
            }
        }
        stage('SAST'){
            steps{
                sh "echo 'running a static application security test analysis with sonarqube'"
                // sh "mvn sonar:sonar"
                sh "sleep 3s"
            }
        }
        stage('UPLOAD-ARTIFACT'){
            steps{
                sh "echo 'uploading the packages'"
                // sh "mvn deploy"
            }
        }
        stage('BUILD-UPLOAD-IMAGE'){
            steps{
                sh "docker build -t oladayur/cicd-demo2:v2 ."
                withCredentials([string(credentialsId: 'DOCKERHUBCRED', variable: 'DOCKERHUBCRED')]) {
                sh "docker login -u oladayur -p ${DOCKERHUBCRED}"
            }
                sh "sleep 5s"
                sh "docker push oladayur/cicd-demo2:v2"
                sh 'docker rmi $(docker images -q) '
            }
        }
        stage('DEPLOY-TO-K8S'){
            steps{
                withCredentials([file(credentialsId: 'K8S-CRED', variable: 'K8S-CRED')]) {
                sh 'kubectl --kubeconfig=${K8S-CRED} apply -f k8s/'
        }
            }
        }
    }

}
