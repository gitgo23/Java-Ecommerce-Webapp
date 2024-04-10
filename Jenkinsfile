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
                dir('project') {
                    sh "mvn clean package"
                }
            }
        } 
    }

    post {
        always {
            echo 'Slack Notifications'
            slackSend channel: 'jenkins-slack-notification', 
                      color: COLOR_MAP[currentBuild.currentResult],
                      message: "${currentBuild.currentResult}: Job ${env.JOB_NAME} \n build ${env.BUILD_NUMBER} \n More info at: ${env.BUILD_URL}"
            
            // Send email notification
            emailext subject: "Pipeline ${currentBuild.result}: ${env.JOB_NAME}",
                      body: "Build ${env.BUILD_NUMBER} ${currentBuild.result}\n\nCheck console output at: ${env.BUILD_URL}",
                      to: "www.gyenoch@gmail.com, enoch3054@gmail.com",
                      attachLog: true
        }
    }
}