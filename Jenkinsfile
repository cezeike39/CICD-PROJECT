pipeline{
    agent any
    environment {
        KUBECONFIG_CREDENTIAL = credentials('KUBECONFIGCRED')
    }

    tools{
        maven "MVN"
    }
    stages{
        stage('codeCloning'){
            steps{
                git "https://github.com/Olakenny/DevOps-Task-Project.git"
            }
        }
        stage('test & build packages'){
            steps{
                sh "mvn clean package"
            }
        }
       stage('SAST'){
            steps{
                sh "echo 'static application security test'"
                // sh "mvn sonar:sonar"
            }
        }
        stage('ArtifactUpload'){
           steps{
              sh "echo 'uploading artifact to nexus'"
             //   sh "mvn deploy"
            }
        }
        stage('build_push_Image'){
            steps{
                sh 'docker build -t  oladayur/cicd-demo:v2 .'
                withCredentials([string(credentialsId: 'DOCKERHUBCRED', variable: 'DOCKERHUBCRED')]) {
                sh 'docker login -u oladayur -p ${DOCKERHUBCRED}'
           }
                sh 'docker push oladayur/cicd-demo:v2'
                sh 'docker rmi $(docker images -q) '
            }
        }
        stage('deployToK8s'){
            steps{
                withCredentials([file(credentialsId: 'KUBECONFIGCRED', variable: 'KUBECONFIGCRED')]) {
                sh 'kubectl --kubeconfig=${KUBECONFIGCRED} apply -f k8s/'
            }
            }
        }
    }
}

