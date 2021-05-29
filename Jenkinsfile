pipeline {

    agent none
    //agent {label 'master'}
    
    environment {
        PASS = credentials('registry-pass')
        IMAGE_PYTHON = 'my-python'
        IMAGE_NODE = 'my-nodejs'
        IMAGE_TAG = "${BUILD_ID}" 
    }
    
    parameters {
        choice(name: 'APP', choices: ['python', 'nodejs', 'all'], description: 'Application')
    }

    stages {

        stage('Build') {
            agent {label 'master'}
            steps {
                sh '''
                    /usr/bin/sh ./jenkins/build/build.sh $APP
                '''
            }

        }

        stage('Push') {
            agent {label 'master'}
            steps {
                sh '/usr/bin/sh ./jenkins/push/push.sh $APP'
            }
        }

        stage('Deploy') {
            agent {label 'node03'}
            steps {
                sh '/usr/bin/sh ./jenkins/deploy/deploy.sh $APP'
            }
        }
    }
    
    post {
        always {
            emailext attachLog: true, body: """<p>Check console output at ${env.BUILD_URL} to view the results.:</p>""", to: '$DEFAULT_RECIPIENTS', subject: """${env.JOB_NAME} - Build # ${env.BUILD_NUMBER} [${currentBuild.currentResult}]"""
        }
    }
}
