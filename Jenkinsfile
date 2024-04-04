pipeline {
    agent any 

    // tools {
    //     maven "maven3"
    // }

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
    }
}