#!groovy
pipeline{

	agent {
		label "JenkinsLocal"
	}

	environment {
		DOCKERHUB_CREDENTIALS=credentials('jerrybopara')
	}
	
	stages {
		 stage('Checking Old Container') {
			steps {
				script {
					// env.OldContainer = sh(script: 'docker images | grep "node" >> /dev/null 2>&1 && echo "FOUND" || echo "NOT FOUND"', returnStdout: true)
					env.OldContainer = sh(script: 'docker ps -a | grep -w ${ContainerName} >> /dev/null 2>&1 && echo "0" || echo "5"', returnStdout: true)
					echo "Container Status - ${env.OldContainer}"
				}
	
			}
		 }	 

		stage('Lets delete the older Container.'){
			steps {
				script { 
					if (env.OldContainer == '0') {
						echo 'Old Container is  running: ${env.OldContainer}'
					} else {
						echo 'No Container Found.'	
						echo "${env.OldContainer}"
					}

				}
			}

		}

		// stage('2nd Stopping & Removing the older Container.') {
		// 	steps {
		// 		sh '''
		// 			docker ps -a | grep ${ContainerName}
					
		// 			if [ $? -eq 0 ]; then 
		// 				ImageID=`docker images | grep "${DockerHubUser}/${ImageName}" | awk '{print $3}'`
		// 				docker stop ${ContainerName}
		// 				docker rm ${ContainerName}
		// 				docker rmi ${ImageID} --force
		// 			fi 	
		// 		'''
		// 	}

		// }

		stage('Building an Docker Image') {

			steps {
				sh 'docker build -t ${ImageName}:latest .'
				sh 'docker tag ${ImageName} ${DockerHubUser}/${ImageName}:$BUILD_NUMBER'

			}

		}

		stage('Run Docker Container with latest Build.') {

			steps {
				// sh 'docker run -d -p 8181:8080 jerrybopara/nodejs-docker-jenkins:$BUILD_NUMBER'
				sh 'docker run -d --name ${ContainerName} -p 8181:8080 ${DockerHubUser}/${ImageName}:$BUILD_NUMBER'
			}
		}

		stage('Login to DockerHub & Pushing Image') {

			steps {
				sh 'echo $DOCKERHUB_CREDENTIALS_PSW | docker login -u $DOCKERHUB_CREDENTIALS_USR --password-stdin'
				// sh 'docker push ${DockerHubUser}/${ImageName}:$BUILD_NUMBER'
			}
		}

	}

	post {
		always {
			sh 'docker logout'
		}
	}	

}
