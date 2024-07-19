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
                sh 'sudo lsof -i :80 || true'
            }
        }
        
        stage('Run Docker Container') {
            steps {
                sh 'docker stop task1-container || true'
                sh 'docker rm task1-container || true'
                sh 'docker run -d -p 80:5000 --name task1-container task1-app'
            }
        }
        
        stage('Check Container Status') {
            steps {
                sh 'docker ps -a'
                sh 'docker logs task1-container'
            }
        }
        
        stage('Check Application Port') {
            steps {
                sh 'docker exec task1-container netstat -tlnp || true'
            }
        }
        
        stage('Check Firewall') {
            steps {
                sh 'sudo iptables -L || true'
            }
        }
        
        stage('Verify Deployment') {
            steps {
                sh 'curl http://localhost:80 || echo "Application not responding"'
            }
        }
    }
    
    post {
        always {
            sh 'docker logs task1-container || true'
        }
    }
}
