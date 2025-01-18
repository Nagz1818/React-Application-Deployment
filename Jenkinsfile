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
                    // Log the branch name to debug branch detection
                    echo "Branch Name: ${env.GIT_BRANCH}"

                    if (env.GIT_BRANCH == 'origin/dev' || env.GIT_BRANCH == 'refs/heads/dev') {
                        dockerImage = docker.build(devRegistry)
                    } else if (env.GIT_BRANCH == 'origin/master' || env.GIT_BRANCH == 'refs/heads/master') {
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
                    if (env.GIT_BRANCH == 'origin/dev' || env.GIT_BRANCH == 'refs/heads/dev') {
                        docker.withRegistry('', registryCredential) {
                            dockerImage.push('latest')
                        }
                    } else if (env.GIT_BRANCH == 'origin/master' || env.GIT_BRANCH == 'refs/heads/master') {
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
