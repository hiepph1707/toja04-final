pipeline {

    agent none
    //agent {label 'master'}
    
    environment {
        PASS = credentials('registry-pass')
        IMAGE_PYTHON = 'my-python'
        IMAGE_NODE = 'my-nodejs'
        IMAGE_TAG = 'latest' 
    }
    
    parameters {
        choice(name: 'APP', choices: ['python', 'nodejs', 'all'], description: 'Application')
    }

    stages {

        stage('Build') {
            agent {label 'master'}
            steps {
                sh '''
                    ./jenkins/build/build.sh $APP
                '''
            }

        }

        stage('Push') {
            agent {label 'master'}
            steps {
                sh './jenkins/push/push.sh $APP'
            }
        }

        stage('Deploy') {
            agent {label 'node2'}
            steps {
                sh './jenkins/deploy/deploy.sh $APP'
            }
        }
    }
    
    post {
        always {
            rocketSend "${env.JOB_NAME} - Build #${env.BUILD_NUMBER} [${currentBuild.currentResult}] (<${env.BUILD_URL}|Open>)"
        }
    }
}
