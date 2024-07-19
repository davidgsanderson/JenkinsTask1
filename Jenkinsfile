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
        
        stage('Check Port 80') {
            steps {
                sh 'netstat -tuln | grep :80 || echo "Port 80 is free"'
            }
        }
        
        stage('Run and Check Docker Container') {
            steps {
                sh 'docker stop task1-container || true'
                sh 'docker rm task1-container || true'
                sh 'docker run -d -p 80:5000 --name task1-container task1-app'
                sh 'sleep 5'  // Give the container a moment to start up
                sh 'docker ps -a'
                sh 'docker logs task1-container'
            }
        }
        
        stage('Check Container Ports') {
            steps {
                sh 'docker port task1-container'
            }
        }
        
        stage('Check Docker Network') {
            steps {
                sh 'docker run --rm --network host appropriate/curl curl -s -o /dev/null -w "%{http_code}" http://localhost:80 || echo "Failed to reach application"'
            }
        }
        
        stage('Verify Deployment') {
            steps {
                sh 'curl -v http://localhost:80 || echo "Application not responding"'
            }
        }
    }
    
    post {
        always {
            sh 'docker logs task1-container || true'
        }
    }
}
