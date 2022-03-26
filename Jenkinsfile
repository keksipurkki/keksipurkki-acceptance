pipeline {
    agent { docker { image 'maven:3-openjdk-17-slim' } }

    stages {
        stage("AcceptanceTest") {
            steps {
                sh "env"
                sh "mvn test"
            }
        }
    }

    post {
        always {
            archiveArtifacts (
                artifacts: 'target/artifacts/**/*'
            )
            junit (
                'target/surefire-reports/*.xml'
            )
        }
        success {
            sh "echo yes!"
        }
    }
}

// vim: set ft=groovy :
