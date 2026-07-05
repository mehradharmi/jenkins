pipeline {
    agent { label 'vinod' }
    
    stages {
        stage("Code") {
            steps {
                echo "This clone code from github"
                
                git url: "https://github.com/mehradharmi/jenkins.git", branch: "master"
            }
        }
        
        stage('Build') {
            steps {
                echo "This is build stage"
                sh "docker build -t simple-app ."
            }
        }
        
        stage("Deploy") {
            steps {
                echo "This is deploy stage"
                
                sh """
                    docker rm -f simple-app || true
                    docker run -d --name simple-app -p 8080:80 simple-app
                """
            }
        }
        
        stage("Verify") {
            steps {
                echo "This is verify stage"

                sh """
                    sleep 5
                    curl http://localhost:8080
                """
            }
        }
    }
}
