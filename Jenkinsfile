pipeline {
            options {timestamps()}

            environment {
                registry = "andriimiroshnyk/jenkins-flask-app"
                registryCredential = 'dockerhub_id'
                dockerImage = ''
            }

            agent none
            stages {
                stage('Check scm') {
                    agent any
                    steps {
                      checkout scm
                    }
                }// stage Build
                stage('Build') {
                    steps {
                      echo "Building ...${BUILD_NUMBER}"
                      echo "Build completed"
                    }
                }// stage Build
                stage('Test') {
                    agent { docker { image 'alpine'
                              args '-u=\"root\"'
                            }
                        }
                    steps {
                      sh 'apk add --update python3 py-pip'
                      sh 'pip install Flask'
                      sh 'pip install xmlrunner'
                      sh 'python3 app_tests.py'
                    }
                    post {
                        always {
                            junit 'test-reports/*.xml'
                            }
                        success {
                            echo "Application testing successfully completed "
                        }
                        failure {
                            echo "Oooppss!!! Tests failed!"
                        } // post
                    } 
                } // stage Test
            }
}