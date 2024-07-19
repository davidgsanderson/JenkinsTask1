pipeline {
    agent any
    
    stages {
        stage('Checkout') {
            steps {
                checkout scm
            }
        }
        
        stage('Build Docker Image') {
            steps {
                dir('Task1') {
                    sh 'docker build -t task1-app .'
                }
            }
        }
        
        stage('Run Docker Container') {
            steps {
                sh 'docker stop task1-container || true'
                sh 'docker rm task1-container || true'
                sh 'docker run -d -p 5500:5500 --name task1-container task1-app'
            }
        }
        
        stage('Verify Deployment') {
            steps {
                sh 'curl http://localhost:5500 || echo "Application not responding"'
            }
        }
    }
    
    post {
        failure {
            sh 'docker logs task1-container'
        }
    }
}
