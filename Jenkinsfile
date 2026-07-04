pipeline {
    agent {
        label 'vinod'
    }
    stages {
        stage("Code") {
            echo "This clone code from github"
            git url: 
        }

        stage('Build') {
            echo "This is build stage"
            sh "docker build -t simple-app ."

        }
        stage("Cleanup") {
            echo "This is cleanup stage"
            sh "docker rmi simple-app"
        }
        stage("Deploy") {
            echo "This is deploy stage"
            sh "docker run -d -p 8080:8080 simple-app"
        }
        stage("verify") {
            echo "This is verify stage"
            sh "curl http://localhost:8080"
        }
    }
}