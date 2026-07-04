pipeline {
    agent {
        label 'vinod'
    }
    stages {
        stage("Code") {
            steps {
            echo "This clone code from github"
            git url: "git@github.com:mehradharmi/jenkins.git", branch: "main"
            }
        }

        stage('Build') {
            steps {
            echo "This is build stage"
            sh "docker build -t simple-app ."
            }
        }
        stage("Cleanup") {
            steps {
            echo "This is cleanup stage"
            sh "docker rm -f simple-app || true"
            }
        }
        stage("Deploy") {
            steps {
            echo "This is deploy stage"
            sh "docker run -d --name simple-app -p 8080:80 simple-app"
            }
        }
        stage("verify") {
            steps {
            echo "This is verify stage"
            sh "curl http://localhost:8080"
            }
        }
    }
}