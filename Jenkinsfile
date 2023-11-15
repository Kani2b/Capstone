pipeline {
    agent any

    environment {
        DOCKER_DEV_REPO = "kani2b/capstone-dev"
        DOCKER_PROD_REPO = "kani2b/capstone-prod"
    }

    stages {
        stage('Checkout Git Repository') {
            steps {
                script {
                    checkout scm
                }
            }
        }

        stage('Build and Push Docker Image') {
            steps {
                script {
                    sh 'chmod +x build.sh'
                    sh 'chmod +x deploy.sh'
                    if (env.BRANCH_NAME == 'master') {
                        sh './deploy.sh'
                    } else {
                        echo 'Skipping deployment as the branch is not master.'
                    }
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
