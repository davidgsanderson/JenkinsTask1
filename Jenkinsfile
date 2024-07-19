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
                sh 'sleep 5'  // Give the container a moment to start up
                sh 'docker ps -a'
                sh 'docker logs task1-container'
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
            sh 'docker inspect task1-container || true'
        }
    }
}
