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

        stage('Scan Dependencies with Owasp') {
            steps {
                dir('project') {
                    dependencyCheck additionalArguments: '--scan ./', odcInstallation: 'DC'
                    dependencyCheckPublisher pattern: '**/dependency-check-report.xml'
                }
            }
        }

        stage('Upload to Nexus') {
            steps {
                nexusArtifactUploader (
                    artifacts: [
                        [
                            artifactId: 'project',
                            classifier: '',
                            file: '/var/lib/jenkins/workspace/Ecommerce-webapp/project/target/project.war',
                            type: 'war'
                        ]
                    ],
                    credentialsId: 'nexus-auth',
                    groupId: 'com.project',
                    nexusUrl: '16.16.158.67:8081', 
                    nexusVersion: 'nexus3', 
                    protocol: 'http', 
                    repository: 'ecommerce', 
                    version: '0.0.1-SNAPSHOT'
                )
            }
        }

        stage('Deploy to Tomcat') {
            steps {
                dir('project') {
                    deploy adapters: [tomcat9(path: '', url: 'http://51.20.105.119:8080')], contextPath: null, war: 'target/*.war'
                }
            }
        }
    }
}