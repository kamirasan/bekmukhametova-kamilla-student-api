// CI pipeline for Kamilla Bekmukhametova — Student API
pipeline {
    agent any

    tools {
        jdk 'jdk21'
    }

    options {
        timestamps()
        disableConcurrentBuilds()
    }

    triggers {
        // Poll GitHub every minute (local Jenkins is not reachable by GitHub webhooks)
        pollSCM('* * * * *')
    }

    environment {
        STUDENT_NAME = 'Kamilla Bekmukhametova'
        IMAGE_NAME   = 'bekmukhametova-kamilla-student-api'
        IMAGE_TAG    = 'v1.1-bekmukhametova-kamilla'
    }

    stages {
        stage('Checkout') {
            steps {
                echo "Student: ${STUDENT_NAME}"
                checkout scm
                sh 'git log --oneline -3'
            }
        }

        stage('Build') {
            steps {
                echo "Building Spring Boot application of ${STUDENT_NAME} with Gradle"
                sh 'chmod +x gradlew && ./gradlew clean bootJar -x test --no-daemon'
            }
        }

        stage('Test') {
            steps {
                echo "Running automated tests for ${STUDENT_NAME}"
                sh './gradlew test --no-daemon'
            }
            post {
                always {
                    junit allowEmptyResults: true, testResults: 'build/test-results/test/*.xml'
                }
            }
        }

        stage('Docker Build') {
            steps {
                echo "Building Docker image ${IMAGE_NAME}:${IMAGE_TAG}"
                sh 'docker build -t ${IMAGE_NAME}:${IMAGE_TAG} -t ${IMAGE_NAME}:build-${BUILD_NUMBER} .'
            }
        }

        stage('Verify') {
            steps {
                sh '''
                    docker image inspect ${IMAGE_NAME}:${IMAGE_TAG} --format "Image ${IMAGE_NAME}:${IMAGE_TAG} exists, created {{.Created}}, size {{.Size}} bytes"
                    docker images ${IMAGE_NAME}
                '''
            }
        }
    }

    post {
        success {
            echo "SUCCESS: pipeline of ${STUDENT_NAME} finished, image ${IMAGE_NAME}:${IMAGE_TAG} is ready"
        }
        failure {
            echo "FAILURE: pipeline of ${STUDENT_NAME} stopped — check the failed stage above"
        }
    }
}
