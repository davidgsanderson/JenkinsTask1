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
                sh 'docker build -t task1-app .'
            }
        }
        
        stage('Run Docker Container') {
            steps {
                sh 'docker stop task1-container || true'
                sh 'docker rm task1-container || true'
                sh 'docker run -d -p 80:5500 --name task1-container task1-app'
            }
        }
        
        stage('Verify Deployment') {
            steps {
                sh 'curl -s http://localhost:80 || echo "Application not responding"'
            }
        }
    }
}
