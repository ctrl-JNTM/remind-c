pipeline {
    options {
        buildDiscarder(logRotator(numToKeepStr: '7', artifactNumToKeepStr: '10', daysToKeepStr: '5'))
        timeout(time: 15, unit: 'MINUTES')
        disableConcurrentBuilds()
    }
    agent {
        label 'master'
    }

    environment {
        NODE_BIN_DIR = 'node_modules/.bin'
        JOB_NAME = 'message-platform-admin'
        SONAR_HOST = "http://106.14.202.15:9000"
        SONAR_LOGIN = '738d3f3e0c612ab043678e6d7f65ceb608da3e28'
    }

    parameters {
            booleanParam(name: 'SKIP_TEST', defaultValue: false, description: '此操作将会跳过单元测试。')
    }

    stages {
        stage('pipeline环境准备') {
            steps {
                script {
                    echo "开始构建"
                    if(!env.BRANCH_NAME.startsWith('feature-') && !env.BRANCH_NAME.startsWith('release-')&& env.BRANCH_NAME!='master'){
                        error("自动构建分支名称必须是dev或以release-开头，当前分支名称为: ${env.BRANCH_NAME}")
                    }

                    if (env.BRANCH_NAME == 'dev') {
                        env.branchname = "origin/dev"
                        env.env = "beta"
                    }
                    if (env.BRANCH_NAME.startsWith('release-')) {
                        env.branchname = "origin/" + env.BRANCH_NAME
                        env.env = "stage"
                    }

                    sh "echo 当前分支 : ${env.BRANCH_NAME}"
                    sh "echo 当前环境 : ${env.env}"
                    sh "echo 当前提交 : ${env.commit}"
                    sh "echo 当前指定分支 : ${env.branchname}"
                    sh "echo WORKSPACE : ${env.WORKSPACE}"
                    sh "echo GIT_BRANCH : ${env.GIT_BRANCH}"
                    sh "echo BUILD_NUMBER : ${env.BUILD_NUMBER}"
                    sh "echo JOB_NAME : ${env.JOB_NAME}"
                }
            }
        }

        stage('sonar静态检测') {
            steps {
                withSonarQubeEnv('sonarQ') {
                    sh './gradlew clean sonarqube -x test'
                }
            }
        }

        stage("sonar检测结果分析") {
            steps {
                timeout(time: 1, unit: 'HOURS') {
                    waitForQualityGate abortPipeline: true
                }
            }
        }
    }
}
