pipeline {
    agent any 

    tools {
        maven "maven3"
    }
    
    environment {
        ScannerHome = tool "sonar-scanner"
    }

    stages {
        stage('Git Clone') {
            steps {
                git branch: 'main', url: 'https://github.com/Chriscloudaz/Java-Ecommerce-Webapp.git'
            }
        }

        stage('Build and Test') {
            steps {
                sh 'mvn clean test package'
            }
        }

        stage('Scan with Sonarqube') {
            steps {
                script {
                    withSonarQubeEnv(credentialsId: 'sonar-token') {
                    sh "${ScannerHome}/bin/sonar-scanner -Dsonar.projectKey=ecommerce-webapp -Dsonar.projectName=ecommerce-success"
                    }
                }
            }
        }
    }
}