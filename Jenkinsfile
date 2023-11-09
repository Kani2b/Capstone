pipeline {
    agent any

    environment {
        DOCKER_DEV_REPO = "https://hub.docker.com/r/kani2b/capstone-dev" // Docker Hub dev repository
        DOCKER_PROD_REPO = "https://hub.docker.com/r/kani2b/capstone-prod" // Docker Hub prod repository
    }

    stages {
        stage('Checkout Git Repository') {
            steps {
                git branch: 'dev', url: 'https://github.com/Kani2b/Capstone.git'
            }
        }

        stage('Build and Push Docker Image') {
            steps {
                script {
                    dir('/var/lib/jenkins/Capstone') { 
                        sh 'chmod +x build.sh'
                        sh 'chmod +x deploy.sh'

                        def branch = sh(returnStdout: true, script: 'git rev-parse --abbrev-ref HEAD').trim()
                        if (branch == 'dev') {
                            sh './build.sh dev' 
                            sh './deploy.sh dev' 
                        } else if (branch == 'master') {
                            sh './build.sh prod' 
                            sh './deploy.sh prod' 
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

