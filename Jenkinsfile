pipeline {
    agent any

    tools {
        maven "Maven-3.9.6"
    }

    stages {
        stage('Git Clone') {
            steps {
               git branch: 'main', url: 'https://github.com/gitgo23/Java-Ecommerce-Webapp.git' 
            }
        }

        stage('Build with Maven') {
            steps {
                sh "mvn clean package"
            }
        } 
    }
}