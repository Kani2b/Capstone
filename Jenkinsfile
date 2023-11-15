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

                    if (env.BRANCH_NAME == 'dev') {
                        echo 'Building and pushing to dev repository'
                        sh './build.sh'
                        sh "docker push $DOCKER_DEV_REPO"
                    } else if (env.BRANCH_NAME == 'master') {
                        echo 'Building and pushing to prod repository'
                        sh './deploy.sh'
                        sh "docker push $DOCKER_PROD_REPO"
                    } else {
                        echo 'Skipping deployment as the branch is neither dev nor master.'
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

