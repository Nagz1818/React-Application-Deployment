pipeline {
    agent any
    environment {
        dockerImage = ''
        devRegistry = 'nagu1618/dev'
        prodRegistry = 'nagu1618/prod'
        registryCredential = 'dockerhub-credentials'
    }
    stages {
        stage('Checkout') {
            steps {
                checkout scm
            }
        }
        stage('Build Docker Image') {
            steps {
                script {
                    if (env.GIT_BRANCH == 'origin/dev') {
                        dockerImage = docker.build(devRegistry)
                    } else if (env.GIT_BRANCH == 'origin/master') {
                        dockerImage = docker.build(prodRegistry)
                    } else {
                        error("Unknown branch: ${env.GIT_BRANCH}")
                    }
                }
            }
        }
        stage('Push Docker Image') {
            steps {
                script {
                    if (env.GIT_BRANCH == 'origin/dev') {
                        docker.withRegistry('', registryCredential) {
                            dockerImage.push('latest')
                        }
                    } else if (env.GIT_BRANCH == 'origin/master') {
                        docker.withRegistry('', registryCredential) {
                            dockerImage.push('latest')
                        }
                    }
                }
            }
        }
    }
    post {
        always {
            cleanWs()
        }
    }
}
