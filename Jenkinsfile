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
                dir('project') {
                    sh 'mvn clean test package'
                }
            }
        }

        stage('Scan with Sonarqube') {
            steps {
                dir('project') {
                    script {
                    // compiledClassesDir = sh(script: 'mvn help:evaluate -Dexpression=project.build.outputDirectory -q -DforceStdout', returnStdout: true).trim()
                    
                    withSonarQubeEnv(credentialsId: 'sonar-token') {
                    sh "${ScannerHome}/bin/sonar-scanner -Dsonar.projectKey=ecommerce-webapp -Dsonar.projectName=ecommerce-success -Dsonar.java.binaries=." 
                        }
                    }
                }  
            }
        }
    }
}