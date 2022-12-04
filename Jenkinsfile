pipeline {
            options {timestamps()}
            environment {
                registry = "dolmatow/jenkins-lab3"
                registryCredential = 'docker-hub2'
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
                      sh 'python3 test.py'
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
                                stage('Image building') {
                    steps {
                        script {
                            dockerImage = docker.build registry + ":$BUILD_NUMBER"
                        }
                    }
                }
                stage('Deploy') {
                    steps {
                        script {
                            docker.withRegistry( '', registryCredential ) {
                                dockerImage.push()
                            }
                        }
                    }
            }
        }
    }
