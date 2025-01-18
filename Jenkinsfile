pipeline {
    agent any

    environment {
        dockerImage = ''
        devRegistry = 'nagu1618/dev'       // Docker Hub repo for dev
        prodRegistry = 'nagu1618/prod'     // Docker Hub repo for prod
        registryCredential = 'dockerhub-credentials' // Docker Hub credentials ID in Jenkins
    }

    stages {
        stage('Checkout') {
            steps {
                // Dynamically checkout the branch Jenkins is building
                checkout scmGit(branches: [[name: "${env.BRANCH_NAME}"]], extensions: [], userRemoteConfigs: [[url: 'https://github.com/Nagz1818/React-Application-Deployment.git']])
            }
        }

        stage('Build Docker Image') {
            steps {
                script {
                    if (env.BRANCH_NAME == 'dev') {
                        // Build Docker image for dev
                        dockerImage = docker.build(devRegistry)
                    } else if (env.BRANCH_NAME == 'master') {
                        // Build Docker image for prod
                        dockerImage = docker.build(prodRegistry)
                    } else {
                        error("Unknown branch: ${env.BRANCH_NAME}. Supported branches are 'dev' and 'master'.")
                    }
                }
            }
        }

        stage('Push Docker Image') {
            steps {
                script {
                    docker.withRegistry('', registryCredential) {
                        if (env.BRANCH_NAME == 'dev') {
                            // Push Docker image to dev registry
                            dockerImage.push('latest')
                        } else if (env.BRANCH_NAME == 'master') {
                            // Push Docker image to prod registry
                            dockerImage.push('latest')
                        }
                    }
                }
            }
        }
    }

    post {
        always {
            cleanWs() // Clean workspace after the pipeline runs
        }
    }
}

