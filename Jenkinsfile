pipeline {
#this pipeline was run on an agent with agent label 'my agent', kindly remove  agent { label 'myagent' } and use 'agent any' if you want it to run on any agent
   agent { label 'myagent' }
    tools {
        maven "maven"
    }

    stages {
        stage('Clone'){
            steps {
                git branch: 'main', url: 'https://github.com/cezeike39/CICD-PROJECT.git'
            }
        }
        stage('Build') {
            steps {
                sh "mvn clean package"
            }

        }
        stage('docker build'){
            steps {
                sh 'docker build -t cezeike39/docker:cicd .'
            }
        }
        stage('Docker Push') {
            steps {
                withCredentials([usernamePassword(credentialsId: 'dockerhub-credentials', passwordVariable: 'DOCKER_PASSWORD', usernameVariable: 'DOCKER_USERNAME')]) {
                    sh '''
                        echo "$DOCKER_PASSWORD" | docker login -u "$DOCKER_USERNAME" --password-stdin
                        docker push cezeike39/docker:cicd
                    '''
                }
            }
        }
        stage('Deploy') {
            steps {
                sh '''
                    docker stop cicd || true
                    docker rm cicd || true
                    docker run -d --name cicd -p 3000:8080 cezeike39/docker:cicd
                '''
            }

