pipeline {

    agent {
        label 'docker'
    }

    environment {
        CONTAINER_REGISTRY = credentials("container-registry")
        BUILD_TAG = "${CONTAINER_REGISTRY_USR}/worldpress-newspaper:latest"
    }

    stages {
        stage ('Build') {
            steps {
                script {

                    def container = docker.build("${BUILD_TAG}")

                }   
            }
        }
        stage ('Upload') {
            steps{
                script {

                    def container = docker.image("${BUILD_TAG}")
                    container.push()

                }
            }
        }
    }

}