pipeline {
   agent any

   environment {
       DOCKER_DEV_REPO = "https://hub.docker.com/r/kani2b/capstone-dev" // Docker Hub dev repository
       DOCKER_PROD_REPO = "https://hub.docker.com/r/kani2b/capstone-prod" // Docker Hub prod repository
   }

   stages {
       stage('Build and Push Docker Image') {
           steps {
               script {
                  git branch: 'dev', url: 'https://github.com/Kani2b/Capstone.git'

                  sh 'chmod +x /home/ubuntu/Capstone/build.sh'
                  sh 'chmod +x /home/ubuntu/Capstone/deploy.sh'

                  def branch = sh(returnStdout: true, script: 'git rev-parse --abbrev-ref HEAD').trim()
                  if (branch == 'dev') {
                      sh '/home/ubuntu/Capstone/build.sh dev' // Full path to build.sh
                      sh '/home/ubuntu/Capstone/deploy.sh dev' // Full path to deploy.sh
                  } else if (branch == 'master') {
                      sh '/home/ubuntu/Capstone/build.sh prod' // Full path to build.sh
                      sh '/home/ubuntu/Capstone/deploy.sh prod' // Full path to deploy.sh
                  } else {
                      echo 'Not triggered by a push to dev or master branch, skipping deployment'
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

