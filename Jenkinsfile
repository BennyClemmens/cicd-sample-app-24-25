pipeline {
    agent any

    stages {
        stage('Preparation') {
            steps {
                catchError(buildResult: 'SUCCESS') {
                    sh 'docker stop samplerunning || true'
                    sh 'docker rm samplerunning || true'
                }
            }
        }
        stage('Build') {
            steps {
                build 'BuildSampleApp'
            }
        }
        stage('Results') {
            steps {
                build 'TestSampleApp'
            }
        }
    }
}
