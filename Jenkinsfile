@Library("shared") _
pipeline {
    agent { label 'vinod' }
    
    stages {
        stage("Hello"){
        steps{
            script{
                hello()            }
        }
    }
        stage("Code") {
            steps {
                script{
                clone("https://github.com/mehradharmi/jenkins.git","master")
                }
            }
        }
        
        stage('Build') {
            steps {
                script{
                docker_build("simple-app","latest","mehradharmi1")
                }
            }
        }
        
        stage('Push to Docker Hub') {
            steps { 
                script{
                    docker_push("simple-app","latest","mehradharmi1")
                }
            }
        }
        
        stage("Deploy") {
            steps {
                echo "Deploying container..."
                // Hub wali fresh image run karne ke liye use update kiya
                withCredentials([
                    usernamePassword(
                        credentialsId: 'dockerHubCred', 
                        passwordVariable: 'dockerHubPass', 
                        usernameVariable: 'dockerHubUser'
                    )
                ]) {
                    sh """
                        docker rm -f simple-app || true
                        docker run -d --name simple-app -p 8080:80 "\$dockerHubUser/simple-app:latest"
                    """
                }
            }
        }
        
        stage("Verify") {
            steps {
                echo "Verifying application status..."
                sh """
                    sleep 5
                    curl -f http://localhost:8080
                """
            }
        }
    }
}
