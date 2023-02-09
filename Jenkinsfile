pipeline{
    agent any
    tools{
        maven 'maven_3.8.7'
    }
    stages{
        stage('remove old containers and images'){
            steps{
                script{
                    sh 'docker container prune --force'
                }
            }
        }
        stage('docker build'){
            steps{
                 script {
                    
                    sh '''
                        docker build -t $JOB_NAME:v1.$BUILD_ID .
                        docker image tag $JOB_NAME:v1.$BUILD_ID sahar449/java-app:v1.$BUILD_ID
                        docker image tag $JOB_NAME:v1.$BUILD_ID sahar449/java-app:latest
                     '''
                    }
                }
            }
        }    
        stage('docker push to docker-hub'){
            steps{
                script{ 
                        withCredentials([string(credentialsId: 'docker_hub_login', variable: 'docker_hub')]) {
                            sh '''
                            docker push sahar449/java-app:v1.$BUILD_ID
                            docker push sahar449/java-app:latest
                             '''
                        }
                    }
                }
            }        
        stage('docker pull from docker-hub'){
            steps{
                script{
                        sh '''
                        docker pull sahar449/java-app:latest 
                        docker run -d --name java-app sahar449/java-app:latest
                        '''
                    }
                }
            }
        stage('print docker logs'){
            steps{
                script{
                    sh 'echo $(docker logs java-app)'
                    }
                }
            }    
        }
        post {
		    always {
			    mail bcc: '', body: "<br>Project: ${env.JOB_NAME} <br>Build Number: ${env.BUILD_NUMBER} <br> URL de build: ${env.BUILD_URL}", cc: '', charset: 'UTF-8', from: '', mimeType: 'text/html', replyTo: '', subject: "${currentBuild.result} CI: Project name -> ${env.JOB_NAME}", to: "saharr449@gmail.com";  
		    }
	    }
    

