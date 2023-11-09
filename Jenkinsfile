pipeline {
    agent any

    environment {
        DOCKER_DEV_REPO = "https://hub.docker.com/repository/docker/kani2b/capstone-dev/general"
        DOCKER_PROD_REPO = "https://hub.docker.com/repository/docker/kani2b/capstone-prod/general"
    }

    stages {
        stage('Checkout') {
            steps {
                git branch: '*/dev', url: 'https://github.com/Kani2b/Capstone.git'
            }
        }

        stage('Build and Push Docker Image') {
            steps {
                script {
                    withCredentials([usernamePassword(credentialsId: 'Docker', usernameVariable: 'DOCKER_USER', passwordVariable: 'DOCKER_PASSWORD')]) {
                        sh 'chmod +x build.sh'
                        sh 'chmod +x deploy.sh'

                        def branch = sh(returnStdout: true, script: 'git rev-parse --abbrev-ref HEAD').trim()
                        if (branch == 'dev' || branch == 'master') {
                            sh "./build.sh $DOCKER_USER $DOCKER_PASSWORD"
                            sh "./deploy.sh $DOCKER_USER $DOCKER_PASSWORD"
                        } else {
                            echo 'Not triggered by a push to dev or master branch, skipping deployment'
                        }
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

