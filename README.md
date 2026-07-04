# Simple Web App

This project demonstrates CI/CD using:

- Jenkins
- Docker
- GitHub
- Nginx

## Run Locally

docker build -t simple-web .

docker run -d -p 8080:80 simple-web