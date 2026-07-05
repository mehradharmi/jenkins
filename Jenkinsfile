pipeline {
    agent { label 'vinod' }
    
    stages {
        stage("Code") {
            steps {
                echo "Cloning code from GitHub..."
                git url: "https://github.com/mehradharmi/jenkins.git", branch: "master"
            }
        }
        
        stage('Build') {
            steps {
                echo "Building local Docker image..."
                sh "docker build -t simple-app ."
            }
        }
        
        stage('Push to Docker Hub') {
            steps { // FIX 1: Steps block add kiya
                echo "Logging into Docker Hub and pushing image..."
                
                // FIX 2: usernamePassword ka syntax sahi kiya
                withCredentials([
                    usernamePassword(
                        credentialsId: 'dockerHubCred', 
                        passwordVariable: 'dockerHubPass', 
                        usernameVariable: 'dockerHubUser'
                    )
                ]) {
                    // FIX 3: Password secure karne ke liye \$ lagaya aur --password-stdin use kiya
                    sh """
                        echo "\$dockerHubPass" | docker login -u "\$dockerHubUser" --password-stdin
                        docker tag simple-app "\$dockerHubUser/simple-app:latest"
                        docker push "\$dockerHubUser/simple-app:latest"
                    """
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
