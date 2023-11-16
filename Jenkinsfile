pipeline {
    agent any

    environment {
        DOCKER_DEV_REPO = "kani2b/capstone-dev"
        DOCKER_PROD_REPO = "kani2b/capstone-prod"
    }

    stages {
        stage('Checkout Git Repository') {
            steps {
                git branch: 'master', url: 'https://github.com/Kani2b/Capstone.git'
            }
        }

        stage('Build and Push Docker Image') {
            steps {
                script {
                    sh 'chmod +x deploy.sh'
                    sh './deploy.sh'
                }
            }
        }
    }

    post {
        success {
            echo "Deployment successful"
        }
        failure {
            echo "Deployment failed"
        }
    }
}
